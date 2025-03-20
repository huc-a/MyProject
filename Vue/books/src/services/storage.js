// 定义存储键名
const STORAGE_KEYS = {
  BOOKS: 'books-data',
  USER: 'user-data',
  CATEGORY: 'category-data',
  BORROW: 'borrow-data'
}

// 初始图书数据
const initialBooks = [
  {
    id: 1,
    title: '三体',
    author: '刘慈欣',
    publisher: '重庆出版社',
    publishDate: '2008-01-01',
    isbn: '9787536692930',
    price: 23.00,
    description: '科幻小说三部曲的第一部',
    categoryId: 1
  },
  {
    id: 2,
    title: '百年孤独',
    author: '加西亚·马尔克斯',
    publisher: '南海出版公司',
    publishDate: '2011-06-01',
    isbn: '9787544253994',
    price: 39.50,
    description: '魔幻现实主义文学代表作',
    categoryId: 2
  },
  {
    id: 3,
    title: '1984',
    author: '乔治·奥威尔',
    publisher: '北京十月文艺出版社',
    publishDate: '2010-04-01',
    isbn: '9787530216971',
    price: 28.00,
    description: '反乌托邦文学经典',
    categoryId: 3
  },
  {
    id: 4,
    title: '活着',
    author: '余华',
    publisher: '作家出版社',
    publishDate: '2012-08-01',
    isbn: '9787506365437',
    price: 20.00,
    description: '讲述了农村人福贵悲惨的人生遭遇',
    categoryId: 2
  },
  {
    id: 5,
    title: '三体Ⅱ：黑暗森林',
    author: '刘慈欣',
    publisher: '重庆出版社',
    publishDate: '2008-05-01',
    isbn: '9787536693968',
    price: 23.00,
    description: '科幻小说三部曲的第二部',
    categoryId: 1
  },
  {
    id: 6,
    title: '三体Ⅲ：死神永生',
    author: '刘慈欣',
    publisher: '重庆出版社',
    publishDate: '2010-11-01',
    isbn: '9787229030933',
    price: 23.00,
    description: '科幻小说三部曲的第三部',
    categoryId: 1
  },
  {
    id: 7,
    title: '动物农场',
    author: '乔治·奥威尔',
    publisher: '上海译文出版社',
    publishDate: '2007-03-01',
    isbn: '9787532739547',
    price: 19.00,
    description: '讽刺寓言小说',
    categoryId: 3
  },
  {
    id: 8,
    title: '围城',
    author: '钱钟书',
    publisher: '人民文学出版社',
    publishDate: '1991-02-01',
    isbn: '9787020024759',
    price: 19.00,
    description: '描写了中国知识分子的生活百态',
    categoryId: 2
  }
]

// 初始用户数据
const initialUsers = [
  {
    id: 1,
    username: 'admin',
    password: '123456',
    role: 'admin',
    name: '管理员'
  },
  {
    id: 2,
    username: 'user1',
    password: '123456',
    role: 'user',
    name: '张三'
  },
  {
    id: 3,
    username: 'user2',
    password: '123456',
    role: 'user',
    name: '李四'
  }
]

// 添加初始分类数据
const initialCategories = [
  {
    id: 1,
    name: '科幻小说',
    description: '科学幻想类小说'
  },
  {
    id: 2,
    name: '文学小说',
    description: '文学类小说'
  },
  {
    id: 3,
    name: '社会小说',
    description: '反映社会现实的小说'
  },
  {
    id: 4,
    name: '历史小说',
    description: '以历史为背景的小说'
  },
  {
    id: 5,
    name: '侦探小说',
    description: '推理侦探类小说'
  }
]

// 添加初始借阅数据
const initialBorrows = [
  {
    id: 1,
    bookId: 1,
    userId: 2,
    borrowDate: '2024-01-01',
    returnDate: '2024-01-15',
    actualReturnDate: '2024-01-14'
  },
  {
    id: 2,
    bookId: 2,
    userId: 2,
    borrowDate: '2024-01-10',
    returnDate: '2024-01-24',
    actualReturnDate: null
  },
  {
    id: 3,
    bookId: 3,
    userId: 3,
    borrowDate: '2024-01-05',
    returnDate: '2024-01-19',
    actualReturnDate: '2024-01-18'
  }
]

class StorageService {
  constructor() {
    this.initializeStorage()
  }

  // 初始化存储
  initializeStorage() {
    if (!localStorage.getItem(STORAGE_KEYS.BOOKS)) {
      localStorage.setItem(STORAGE_KEYS.BOOKS, JSON.stringify(initialBooks))
    }
    if (!localStorage.getItem(STORAGE_KEYS.USER)) {
      localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(initialUsers))
    }
    if (!localStorage.getItem(STORAGE_KEYS.CATEGORY)) {
      localStorage.setItem(STORAGE_KEYS.CATEGORY, JSON.stringify(initialCategories))
    }
    if (!localStorage.getItem(STORAGE_KEYS.BORROW)) {
      localStorage.setItem(STORAGE_KEYS.BORROW, JSON.stringify(initialBorrows))
    }
  }

  // 图书相关方法
  getBooks() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.BOOKS) || '[]')
  }

  saveBooks(books) {
    localStorage.setItem(STORAGE_KEYS.BOOKS, JSON.stringify(books))
  }

  // 用户相关方法
  getUsers() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.USER) || '[]')
  }

  validateUser(username, password) {
    const users = this.getUsers()
    return users.find(user => 
      user.username === username && user.password === password
    )
  }

  resetStorage() {
    localStorage.setItem(STORAGE_KEYS.BOOKS, JSON.stringify(initialBooks))
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(initialUsers))
    localStorage.setItem(STORAGE_KEYS.CATEGORY, JSON.stringify(initialCategories))
    localStorage.setItem(STORAGE_KEYS.BORROW, JSON.stringify(initialBorrows))
  }

  saveUsers(users) {
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(users))
  }

  getCategories() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.CATEGORY) || '[]')
  }

  saveCategories(categories) {
    localStorage.setItem(STORAGE_KEYS.CATEGORY, JSON.stringify(categories))
  }

  getBorrows() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.BORROW) || '[]')
  }

  saveBorrows(borrows) {
    localStorage.setItem(STORAGE_KEYS.BORROW, JSON.stringify(borrows))
  }
}

export const storageService = new StorageService() 