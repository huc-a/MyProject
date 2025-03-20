<template>
  <el-container class="layout-container">
    <el-header>
      <div class="header-content">
        <h2>图书管理系统</h2>
        <div class="user-info">
          <el-dropdown @command="handleCommand">
            <span class="user-dropdown">
              {{ userStore.user?.name }}
              <el-icon><ArrowDown /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </el-header>
    
    <el-container>
      <el-aside width="200px">
        <el-menu
          router
          :default-active="$route.path"
          class="el-menu-vertical"
        >
          <el-menu-item index="/home/books">
            <el-icon><Document /></el-icon>
            <span>图书列表</span>
          </el-menu-item>
          <el-menu-item v-if="userStore.user?.role === 'admin'" index="/home/users">
            <el-icon><User /></el-icon>
            <span>用户管理</span>
          </el-menu-item>
          <el-menu-item v-if="userStore.user?.role === 'admin'" index="/home/categories">
            <el-icon><Folder /></el-icon>
            <span>分类管理</span>
          </el-menu-item>
          <el-menu-item index="/home/borrows">
            <el-icon><Tickets /></el-icon>
            <span>借阅记录</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { Document, Plus, User, ArrowDown, Folder, Tickets } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'

const router = useRouter()
const userStore = useUserStore()

const handleCommand = (command) => {
  switch (command) {
    case 'profile':
      router.push('/home/profile')
      break
    case 'logout':
      userStore.logout()
      router.push('/login')
      break
  }
}
</script>

<style scoped lang="scss">
.layout-container {
  height: 100vh;
  
  .el-header {
    background-color: #409EFF;
    color: white;
    padding: 0 20px;
    
    .header-content {
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: space-between;
      
      .user-info {
        .user-dropdown {
          color: white;
          cursor: pointer;
          display: flex;
          align-items: center;
          gap: 4px;
        }
      }
    }
  }
  
  .el-aside {
    background-color: #f5f7fa;
    border-right: solid 1px #e6e6e6;
    
    .el-menu {
      border-right: none;
    }
  }
  
  .el-main {
    padding: 20px;
    background-color: #fff;
  }
}
</style> 