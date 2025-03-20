<template>
  <div class="profile">
    <el-card class="profile-card">
      <template #header>
        <div class="card-header">
          <h3>个人信息</h3>
          <el-button type="primary" @click="handleEdit">修改信息</el-button>
        </div>
      </template>
      
      <div class="info-list">
        <div class="info-item">
          <label>用户名：</label>
          <span>{{ userStore.user?.username }}</span>
        </div>
        <div class="info-item">
          <label>姓名：</label>
          <span>{{ userStore.user?.name }}</span>
        </div>
        <div class="info-item">
          <label>角色：</label>
          <el-tag :type="userStore.user?.role === 'admin' ? 'danger' : 'info'">
            {{ userStore.user?.role === 'admin' ? '管理员' : '普通用户' }}
          </el-tag>
        </div>
      </div>
    </el-card>

    <!-- 修改信息对话框 -->
    <el-dialog
      v-model="dialogVisible"
      title="修改信息"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="userForm"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="姓名" prop="name">
          <el-input v-model="userForm.name" />
        </el-form-item>
        <el-form-item label="旧密码" prop="oldPassword">
          <el-input 
            v-model="userForm.oldPassword" 
            type="password"
            placeholder="修改密码时必填"
          />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input 
            v-model="userForm.newPassword" 
            type="password"
            placeholder="不修改请留空"
          />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input 
            v-model="userForm.confirmPassword" 
            type="password"
            placeholder="不修改请留空"
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
import { ref } from 'vue'
import { useUserStore } from '../stores/user'
import { ElMessage } from 'element-plus'
import { storageService } from '../services/storage'

const userStore = useUserStore()
const dialogVisible = ref(false)
const formRef = ref(null)

const userForm = ref({
  name: '',
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const validatePass = (rule, value, callback) => {
  if (userForm.value.newPassword && !value) {
    callback(new Error('请确认密码'))
  } else if (value !== userForm.value.newPassword) {
    callback(new Error('两次输入密码不一致!'))
  } else {
    callback()
  }
}

const rules = {
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' }
  ],
  oldPassword: [
    { 
      required: false,
      validator: (rule, value, callback) => {
        if (userForm.value.newPassword && !value) {
          callback(new Error('修改密码时必须输入旧密码'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ],
  newPassword: [
    { min: 6, message: '密码至少6个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { validator: validatePass, trigger: 'blur' }
  ]
}

const handleEdit = () => {
  userForm.value = {
    name: userStore.user?.name || '',
    oldPassword: '',
    newPassword: '',
    confirmPassword: ''
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      const users = storageService.getUsers()
      const index = users.findIndex(u => u.username === userStore.user?.username)
      
      if (index === -1) {
        ElMessage.error('用户不存在')
        return
      }

      // 如果要修改密码，验证旧密码
      if (userForm.value.newPassword) {
        if (users[index].password !== userForm.value.oldPassword) {
          ElMessage.error('旧密码不正确')
          return
        }
      }

      // 更新用户信息
      const updatedUser = {
        ...users[index],
        name: userForm.value.name
      }

      if (userForm.value.newPassword) {
        updatedUser.password = userForm.value.newPassword
      }

      users[index] = updatedUser
      storageService.saveUsers(users)
      
      // 更新当前用户信息
      userStore.updateCurrentUser(updatedUser)
      
      dialogVisible.value = false
      ElMessage.success('修改成功')
    }
  })
}
</script>

<style scoped lang="scss">
.profile {
  max-width: 800px;
  margin: 0 auto;

  .profile-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .info-list {
      .info-item {
        margin-bottom: 20px;
        
        label {
          font-weight: bold;
          margin-right: 10px;
          color: #666;
        }
      }
    }
  }
}
</style> 