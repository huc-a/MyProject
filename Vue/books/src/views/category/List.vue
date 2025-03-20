<template>
  <div class="category-list">
    <div class="table-header">
      <h3>分类管理</h3>
      <el-button type="primary" @click="handleAdd">
        添加分类
      </el-button>
    </div>
    
    <el-table :data="categories" style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" label="分类名称" />
      <el-table-column prop="description" label="描述" />
      <el-table-column prop="bookCount" label="图书数量" width="100" />
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button
            type="primary"
            size="small"
            @click="handleEdit(row)"
          >
            编辑
          </el-button>
          <el-button
            type="danger"
            size="small"
            @click="handleDelete(row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分类表单对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEdit ? '编辑分类' : '添加分类'"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="categoryForm"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="分类名称" prop="name">
          <el-input v-model="categoryForm.name" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="categoryForm.description"
            type="textarea"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">
          确定
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { ElMessageBox, ElMessage } from 'element-plus'
import { storageService } from '../../services/storage'
import { useBookStore } from '../../stores/book'

const bookStore = useBookStore()
const categories = ref([])
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)

const categoryForm = ref({
  name: '',
  description: ''
})

const rules = {
  name: [
    { required: true, message: '请输入分类名称', trigger: 'blur' },
    { min: 2, message: '分类名称至少2个字符', trigger: 'blur' }
  ],
  description: [
    { required: true, message: '请输入描述', trigger: 'blur' }
  ]
}

// 计算每个分类下的图书数量
const loadCategories = () => {
  const allCategories = storageService.getCategories()
  const books = bookStore.books
  categories.value = allCategories.map(category => ({
    ...category,
    bookCount: books.filter(book => book.categoryId === category.id).length
  }))
}

const handleAdd = () => {
  isEdit.value = false
  categoryForm.value = {
    name: '',
    description: ''
  }
  dialogVisible.value = true
}

const handleEdit = (row) => {
  isEdit.value = true
  categoryForm.value = { ...row }
  dialogVisible.value = true
}

const handleDelete = (row) => {
  // 检查分类下是否有图书
  const books = bookStore.books
  if (books.some(book => book.categoryId === row.id)) {
    ElMessage.warning('该分类下还有图书，不能删除')
    return
  }

  ElMessageBox.confirm('确定要删除该分类吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    const categories = storageService.getCategories()
    const index = categories.findIndex(c => c.id === row.id)
    if (index > -1) {
      categories.splice(index, 1)
      storageService.saveCategories(categories)
      loadCategories()
      ElMessage.success('删除成功')
    }
  })
}

const handleSubmit = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      const categories = storageService.getCategories()
      if (isEdit.value) {
        const index = categories.findIndex(c => c.id === categoryForm.value.id)
        if (index > -1) {
          categories[index] = { ...categoryForm.value }
        }
      } else {
        const newCategory = {
          ...categoryForm.value,
          id: Math.max(0, ...categories.map(c => c.id)) + 1
        }
        categories.push(newCategory)
      }
      
      storageService.saveCategories(categories)
      loadCategories()
      dialogVisible.value = false
      ElMessage.success(isEdit.value ? '更新成功' : '添加成功')
    }
  })
}

onMounted(() => {
  loadCategories()
})
</script>

<style scoped lang="scss">
.category-list {
  .table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
}
</style> 