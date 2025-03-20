import { defineStore } from 'pinia'
import { ref } from 'vue'
import { storageService } from '../services/storage'
import { useRouter } from 'vue-router'

export const useUserStore = defineStore('user', () => {
  const token = ref(localStorage.getItem('token') || '')
  const user = ref(null)
  const router = useRouter()

  async function login(username, password) {
    try {
      const validUser = storageService.validateUser(username, password)
      if (validUser) {
        const mockToken = btoa(`${username}-${Date.now()}`)
        token.value = mockToken
        user.value = validUser
        localStorage.setItem('token', token.value)
        localStorage.setItem('user', JSON.stringify(validUser))
        router.push('/home/books')
        return true
      }
      return false
    } catch (error) {
      console.error('登录失败:', error)
      return false
    }
  }

  function logout() {
    token.value = ''
    user.value = null
    localStorage.removeItem('token')
    localStorage.removeItem('user')
  }

  function updateCurrentUser(userData) {
    user.value = userData
    localStorage.setItem('user', JSON.stringify(userData))
  }

  return { token, user, login, logout, updateCurrentUser }
}) 