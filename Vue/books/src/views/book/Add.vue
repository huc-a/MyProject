<template>
  <div class="book-add">
    <h3>添加图书</h3>
    <el-form
      :model="bookForm"
      :rules="rules"
      ref="formRef"
      label-width="100px"
      class="book-form"
    >
      <el-form-item label="书名" prop="title">
        <el-input v-model="bookForm.title" />
      </el-form-item>
      
      <el-form-item label="作者" prop="author">
        <el-input v-model="bookForm.author" />
      </el-form-item>
      
      <el-form-item label="出版社" prop="publisher">
        <el-input v-model="bookForm.publisher" />
      </el-form-item>

      <el-form-item label="ISBN" prop="isbn">
        <el-input v-model="bookForm.isbn" />
      </el-form-item>

      <el-form-item label="价格" prop="price">
        <el-input-number 
          v-model="bookForm.price" 
          :precision="2" 
          :step="0.1" 
          :min="0"
        />
      </el-form-item>
      
      <el-form-item label="出版日期" prop="publishDate">
        <el-date-picker
          v-model="bookForm.publishDate"
          type="date"
          placeholder="选择日期"
          value-format="YYYY-MM-DD"
        />
      </el-form-item>

      <el-form-item label="简介" prop="description">
        <el-input
          v-model="bookForm.description"
          type="textarea"
          :rows="4"
          placeholder="请输入图书简介"
        />
      </el-form-item>

      <el-form-item label="分类" prop="categoryId">
        <el-select v-model="bookForm.categoryId" placeholder="请选择分类">
          <el-option
            v-for="category in categories"
            :key="category.id"
            :label="category.name"
            :value="category.id"
          />
        </el-select>
      </el-form-item>
      
      <el-form-item>
        <el-button type="primary" @click="handleSubmit">提交</el-button>
        <el-button @click="$router.push('/home/books')">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useBookStore } from '../../stores/book'
import { ElMessage } from 'element-plus'
import { storageService } from '../../services/storage'

const router = useRouter()
const bookStore = useBookStore()
const formRef = ref(null)
const categories = ref([])

const bookForm = ref({
  title: '',
  author: '',
  publisher: '',
  isbn: '',
  price: 0,
  publishDate: '',
  description: '',
  categoryId: ''
})

const rules = {
  title: [{ required: true, message: '请输入书名', trigger: 'blur' }],
  author: [{ required: true, message: '请输入作者', trigger: 'blur' }],
  publisher: [{ required: true, message: '请输入出版社', trigger: 'blur' }],
  isbn: [{ required: true, message: '请输入ISBN', trigger: 'blur' }],
  price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
  publishDate: [{ required: true, message: '请选择出版日期', trigger: 'change' }],
  description: [{ required: true, message: '请输入图书简介', trigger: 'blur' }],
  categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }]
}

const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      await bookStore.addBook(bookForm.value)
      ElMessage.success('添加成功')
      router.push('/home/books')
    }
  })
}

onMounted(() => {
  categories.value = storageService.getCategories()
})
</script>

<style scoped lang="scss">
.book-add {
  .book-form {
    max-width: 600px;
    margin-top: 20px;
  }
}
</style> 