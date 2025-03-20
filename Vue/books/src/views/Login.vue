<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-left">
        <div class="welcome-text">
          <h1>图书管理系统</h1>
          <p>Knowledge is power, library is the temple of knowledge</p>
        </div>
      </div>
      <div class="login-right">
        <el-card class="login-card" :body-style="{ padding: '40px' }">
          <template #header>
            <div class="card-header">
              <h2>用户登录</h2>
              <p class="sub-title">欢迎回来，请登录您的账号</p>
            </div>
          </template>
          <el-form 
            :model="loginForm" 
            @submit.prevent="handleLogin"
            :rules="rules"
            ref="formRef"
          >
            <el-form-item prop="username">
              <el-input
                v-model="loginForm.username"
                placeholder="用户名"
                :prefix-icon="User"
                size="large"
              />
            </el-form-item>
            <el-form-item prop="password">
              <el-input
                v-model="loginForm.password"
                type="password"
                placeholder="密码"
                :prefix-icon="Lock"
                size="large"
                show-password
              />
            </el-form-item>
            <div class="remember-forgot">
              <el-checkbox v-model="rememberMe">记住我</el-checkbox>
              <el-link type="primary" :underline="false">忘记密码？</el-link>
            </div>
            <el-form-item>
              <el-button 
                type="primary" 
                native-type="submit" 
                :loading="loading"
                size="large"
                class="submit-btn"
              >
                登录
              </el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import { ElMessage } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()
const formRef = ref(null)
const loading = ref(false)
const rememberMe = ref(false)

const loginForm = ref({
  username: '',
  password: ''
})

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, message: '用户名至少3个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码至少6个字符', trigger: 'blur' }
  ]
}

async function handleLogin() {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        if (await userStore.login(loginForm.value.username, loginForm.value.password)) {
          ElMessage.success('登录成功')
          router.push('/home/books')
        } else {
          ElMessage.error('用户名或密码错误')
        }
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<style scoped lang="scss">
.login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #e6f7ff 0%, #f0f5ff 100%);
  
  .login-box {
    display: flex;
    width: 900px;
    height: 500px;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    animation: fadeIn 0.5s ease-out;
    
    .login-left {
      flex: 1;
      background: linear-gradient(135deg, #f0f5ff 0%, #e6f7ff 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px;
      
      .welcome-text {
        color: #1890ff;
        text-align: center;
        
        h1 {
          font-size: 32px;
          margin-bottom: 20px;
          font-weight: 600;
        }
        
        p {
          font-size: 16px;
          color: #666;
          line-height: 1.6;
        }
      }
    }
    
    .login-right {
      flex: 1;
      padding: 40px;
      display: flex;
      align-items: center;
      
      .login-card {
        width: 100%;
        border: none;
        
        .card-header {
          text-align: center;
          padding: 0 0 20px 0;
          
          h2 {
            font-size: 24px;
            color: #1a1a1a;
            margin-bottom: 8px;
          }
          
          .sub-title {
            color: #666;
            font-size: 14px;
          }
        }
        
        :deep(.el-input__wrapper) {
          background-color: #fafafa;
          border: 1px solid #f0f0f0;
          
          &:hover {
            border-color: #1890ff;
          }
          
          &.is-focus {
            background-color: white;
            border-color: #1890ff;
            box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
          }
        }
        
        .remember-forgot {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 24px;
        }
        
        .submit-btn {
          width: 100%;
          height: 44px;
          font-size: 16px;
          background: linear-gradient(90deg, #1890ff 0%, #40a9ff 100%);
          border: none;
          
          &:hover {
            background: linear-gradient(90deg, #40a9ff 0%, #1890ff 100%);
          }
        }
      }
    }
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

// 响应式设计
@media screen and (max-width: 768px) {
  .login-container {
    padding: 20px;
    
    .login-box {
      width: 100%;
      flex-direction: column;
      height: auto;
      
      .login-left {
        padding: 40px 20px;
      }
      
      .login-right {
        padding: 20px;
      }
    }
  }
}
</style> 