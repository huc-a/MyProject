<template>
  <div class="user-list">
    <div class="table-header">
      <h3>用户管理</h3>
      <el-button type="primary" @click="handleAdd">
        添加用户
      </el-button>
    </div>
    
    <el-table :data="users" style="width: 100%">
      <el-table-column prop="username" label="用户名" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="role" label="角色">
        <template #default="{ row }">
          <el-tag :type="row.role === 'admin' ? 'danger' : 'info'">
            {{ row.role === 'admin' ? '管理员' : '普通用户' }}
          </el-tag>
        </template>
      </el-table-column>
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
            :disabled="row.username === 'admin'"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 用户表单对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEdit ? '编辑用户' : '添加用户'"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="userForm"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="用户名" prop="username">
          <el-input 
            v-model="userForm.username" 
            :disabled="isEdit"
          />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input 
            v-model="userForm.password" 
            type="password"
            placeholder="不修改请留空"
            :required="!isEdit"
          />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="userForm.name" />
        </el-form-item>
        <el-form-item label="角色" prop="role">
          <el-select v-model="userForm.role">
            <el-option label="管理员" value="admin" />
            <el-option label="普通用户" value="user" />
          </el-select>
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
import { ref, onMounted } from 'vue'
import { ElMessageBox, ElMessage } from 'element-plus'
import { storageService } from '../../services/storage'

const users = ref([])
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)

const userForm = ref({
  username: '',
  password: '',
  name: '',
  role: 'user'
})

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, message: '用户名至少3个字符', trigger: 'blur' }
  ],
  password: [
    { required: false, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码至少6个字符', trigger: 'blur' }
  ],
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' }
  ],
  role: [
    { required: true, message: '请选择角色', trigger: 'change' }
  ]
}

const loadUsers = () => {
  users.value = storageService.getUsers()
}

const handleAdd = () => {
  isEdit.value = false
  userForm.value = {
    username: '',
    password: '',
    name: '',
    role: 'user'
  }
  dialogVisible.value = true
}

const handleEdit = (row) => {
  isEdit.value = true
  userForm.value = {
    ...row,
    password: '' // 不显示密码
  }
  dialogVisible.value = true
}

const handleDelete = (row) => {
  if (row.username === 'admin') {
    ElMessage.warning('不能删除管理员账号')
    return
  }

  ElMessageBox.confirm('确定要删除该用户吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    const users = storageService.getUsers()
    const index = users.findIndex(u => u.username === row.username)
    if (index > -1) {
      users.splice(index, 1)
      storageService.saveUsers(users)
      loadUsers()
      ElMessage.success('删除成功')
    }
  })
}

const handleSubmit = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      const users = storageService.getUsers()
      if (isEdit.value) {
        // 编辑用户
        const index = users.findIndex(u => u.username === userForm.value.username)
        if (index > -1) {
          const updatedUser = { ...users[index], ...userForm.value }
          if (!userForm.value.password) {
            delete updatedUser.password // 如果密码为空，保持原密码
          }
          users[index] = updatedUser
        }
      } else {
        // 添加用户
        if (users.some(u => u.username === userForm.value.username)) {
          ElMessage.error('用户名已存在')
          return
        }
        users.push(userForm.value)
      }
      
      storageService.saveUsers(users)
      loadUsers()
      dialogVisible.value = false
      ElMessage.success(isEdit.value ? '更新成功' : '添加成功')
    }
  })
}

onMounted(() => {
  loadUsers()
})
</script>

<style scoped lang="scss">
.user-list {
  .table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
}
</style> 