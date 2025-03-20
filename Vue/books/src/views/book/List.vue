<template>
  <div class="book-list">
    <div class="table-header">
      <div class="left">
        <h3>图书列表</h3>
        <el-input
          v-model="searchQuery"
          placeholder="搜索书名/作者/出版社"
          class="search-input"
          clearable
          @input="handleSearch"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>
      </div>
      <el-button type="primary" @click="$router.push('/home/books/add')">
        添加图书
      </el-button>
    </div>
    
    <el-table :data="displayBooks" style="width: 100%" v-loading="loading">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="title" label="书名" />
      <el-table-column prop="author" label="作者" />
      <el-table-column prop="publisher" label="出版社" />
      <el-table-column prop="isbn" label="ISBN" />
      <el-table-column prop="price" label="价格">
        <template #default="{ row }">
          ¥{{ row.price.toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="publishDate" label="出版日期" />
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button
            type="primary"
            size="small"
            @click="handleView(row)"
          >
            查看
          </el-button>
          <el-button
            type="primary"
            size="small"
            @click="$router.push(`/home/books/edit/${row.id}`)"
          >
            编辑
          </el-button>
          <el-button
            type="danger"
            size="small"
            @click="handleDelete(row.id)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 查看详情对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="图书详情"
      width="500px"
    >
      <div v-if="currentBook" class="book-detail">
        <div class="detail-item">
          <label>书名：</label>
          <span>{{ currentBook.title }}</span>
        </div>
        <div class="detail-item">
          <label>作者：</label>
          <span>{{ currentBook.author }}</span>
        </div>
        <div class="detail-item">
          <label>出版社：</label>
          <span>{{ currentBook.publisher }}</span>
        </div>
        <div class="detail-item">
          <label>ISBN：</label>
          <span>{{ currentBook.isbn }}</span>
        </div>
        <div class="detail-item">
          <label>价格：</label>
          <span>¥{{ currentBook.price.toFixed(2) }}</span>
        </div>
        <div class="detail-item">
          <label>出版日期：</label>
          <span>{{ currentBook.publishDate }}</span>
        </div>
        <div class="detail-item">
          <label>简介：</label>
          <p>{{ currentBook.description }}</p>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useBookStore } from '../../stores/book'
import { ElMessageBox, ElMessage } from 'element-plus'
import { Search } from '@element-plus/icons-vue'

const bookStore = useBookStore()
const searchQuery = ref('')
const displayBooks = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const currentBook = ref(null)

const loadBooks = async () => {
  loading.value = true
  try {
    displayBooks.value = await bookStore.fetchBooks(searchQuery.value)
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  loadBooks()
}

const handleView = (book) => {
  currentBook.value = book
  dialogVisible.value = true
}

const handleDelete = (id) => {
  ElMessageBox.confirm('确定要删除这本书吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    await bookStore.deleteBook(id)
    ElMessage.success('删除成功')
    loadBooks()
  })
}

onMounted(() => {
  loadBooks()
})
</script>

<style scoped lang="scss">
.book-list {
  .table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;

    .left {
      display: flex;
      align-items: center;
      gap: 20px;

      .search-input {
        width: 300px;
      }
    }
  }
}

.book-detail {
  .detail-item {
    margin-bottom: 15px;

    label {
      font-weight: bold;
      margin-right: 10px;
      color: #666;
    }

    p {
      margin: 10px 0 0;
      line-height: 1.6;
      color: #666;
    }
  }
}
</style> 