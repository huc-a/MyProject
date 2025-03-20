import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Layout from '../views/Layout.vue'
import BookList from '../views/book/List.vue'
import BookEdit from '../views/book/Edit.vue'
import BookAdd from '../views/book/Add.vue'
import UserList from '../views/user/List.vue'
import Profile from '../views/Profile.vue'
import CategoryList from '../views/category/List.vue'
import BorrowList from '../views/borrow/List.vue'

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/home',
    component: Layout,
    redirect: '/home/books',
    children: [
      {
        path: '/home/books',
        name: 'BookList',
        component: BookList
      },
      {
        path: '/home/books/add',
        name: 'BookAdd',
        component: BookAdd
      },
      {
        path: '/home/books/edit/:id',
        name: 'BookEdit',
        component: BookEdit
      },
      {
        path: '/home/profile',
        name: 'Profile',
        component: Profile
      },
      {
        path: '/home/users',
        name: 'UserList',
        component: UserList,
        meta: { requiresAdmin: true }
      },
      {
        path: '/home/categories',
        name: 'CategoryList',
        component: CategoryList,
        meta: { requiresAdmin: true }
      },
      {
        path: '/home/borrows',
        name: 'BorrowList',
        component: BorrowList
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  const user = JSON.parse(localStorage.getItem('user') || 'null')

  if (to.path === '/login') {
    next()
    return
  }

  if (!token) {
    next('/login')
    return
  }

  // 检查管理员权限
  if (to.meta.requiresAdmin && user?.role !== 'admin') {
    ElMessage.error('需要管理员权限')
    next(from.path)
    return
  }

  next()
})

export default router 