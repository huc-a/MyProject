<template>
  <div class="borrow-list">
    <div class="table-header">
      <h3>借阅记录</h3>
      <el-button 
        type="primary" 
        @click="handleBorrow"
        v-if="userStore.user?.role !== 'admin'"
      >
        借阅图书
      </el-button>
    </div>
    
    <el-table :data="borrowRecords" style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column label="图书信息">
        <template #default="{ row }">
          <div>{{ row.book.title }}</div>
          <div class="book-info">
            <small>{{ row.book.author }} / {{ row.book.publisher }}</small>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="借阅人">
        <template #default="{ row }">
          {{ row.user.name }}
          <el-tag size="small" type="info">{{ row.user.username }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="borrowDate" label="借阅日期" width="120" />
      <el-table-column prop="returnDate" label="应还日期" width="120" />
      <el-table-column prop="actualReturnDate" label="实际归还日期" width="120" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getBorrowStatus(row).type">
            {{ getBorrowStatus(row).label }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="120" fixed="right">
        <template #default="{ row }">
          <el-button
            v-if="canReturn(row)"
            type="success"
            size="small"
            @click="handleReturn(row)"
          >
            归还
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 借阅图书对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="借阅图书"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="borrowForm"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="图书" prop="bookId">
          <el-select 
            v-model="borrowForm.bookId" 
            placeholder="请选择图书"
            filterable
          >
            <el-option
              v-for="book in availableBooks"
              :key="book.id"
              :label="`${book.title} - ${book.author}`"
              :value="book.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="借阅天数" prop="days">
          <el-input-number 
            v-model="borrowForm.days" 
            :min="1" 
            :max="30"
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
import { useUserStore } from '../../stores/user'
import { useBookStore } from '../../stores/book'
import dayjs from 'dayjs'

const userStore = useUserStore()
const bookStore = useBookStore()
const borrowRecords = ref([])
const dialogVisible = ref(false)
const formRef = ref(null)

const borrowForm = ref({
  bookId: '',
  days: 7
})

const rules = {
  bookId: [
    { required: true, message: '请选择图书', trigger: 'change' }
  ],
  days: [
    { required: true, message: '请输入借阅天数', trigger: 'blur' },
    { type: 'number', min: 1, max: 30, message: '借阅天数在1-30天之间', trigger: 'blur' }
  ]
}

// 获取可借阅的图书（未被借出的图书）
const availableBooks = computed(() => {
  const borrowedBookIds = borrowRecords.value
    .filter(record => !record.actualReturnDate)
    .map(record => record.bookId)
  return bookStore.books.filter(book => !borrowedBookIds.includes(book.id))
})

// 获取借阅状态
const getBorrowStatus = (record) => {
  if (record.actualReturnDate) {
    return { type: 'success', label: '已归还' }
  }
  const isOverdue = dayjs(record.returnDate).isBefore(dayjs())
  return isOverdue 
    ? { type: 'danger', label: '已逾期' }
    : { type: 'warning', label: '借阅中' }
}

// 判断是否可以归还
const canReturn = (record) => {
  return !record.actualReturnDate && 
    (userStore.user?.role === 'admin' || record.userId === userStore.user?.id)
}

const loadBorrows = () => {
  const allBorrows = storageService.getBorrows()
  // 如果是普通用户，只显示自己的借阅记录
  borrowRecords.value = allBorrows
    .filter(record => 
      userStore.user?.role === 'admin' || 
      record.userId === userStore.user?.id
    )
    .map(record => ({
      ...record,
      book: bookStore.books.find(b => b.id === record.bookId),
      user: storageService.getUsers().find(u => u.id === record.userId)
    }))
}

const handleBorrow = () => {
  borrowForm.value = {
    bookId: '',
    days: 7
  }
  dialogVisible.value = true
}

const handleReturn = (row) => {
  ElMessageBox.confirm('确定要归还这本书吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    const borrows = storageService.getBorrows()
    const index = borrows.findIndex(b => b.id === row.id)
    if (index > -1) {
      borrows[index].actualReturnDate = dayjs().format('YYYY-MM-DD')
      storageService.saveBorrows(borrows)
      loadBorrows()
      ElMessage.success('归还成功')
    }
  })
}

const handleSubmit = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      const borrows = storageService.getBorrows()
      const newBorrow = {
        id: Math.max(0, ...borrows.map(b => b.id)) + 1,
        bookId: borrowForm.value.bookId,
        userId: userStore.user?.id,
        borrowDate: dayjs().format('YYYY-MM-DD'),
        returnDate: dayjs().add(borrowForm.value.days, 'day').format('YYYY-MM-DD'),
        actualReturnDate: null
      }
      
      borrows.push(newBorrow)
      storageService.saveBorrows(borrows)
      loadBorrows()
      dialogVisible.value = false
      ElMessage.success('借阅成功')
    }
  })
}

onMounted(() => {
  loadBorrows()
})
</script>

<style scoped lang="scss">
.borrow-list {
  .table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .book-info {
    color: #666;
    font-size: 12px;
    margin-top: 4px;
  }
}
</style> 