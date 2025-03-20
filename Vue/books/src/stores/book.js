import { defineStore } from 'pinia'
import { ref } from 'vue'
import { storageService } from '../services/storage'

export const useBookStore = defineStore('book', () => {
  const books = ref(storageService.getBooks())
  const currentBook = ref(null)

  async function fetchBooks(query = '') {
    const allBooks = storageService.getBooks()
    if (query) {
      const loweredQuery = query.toLowerCase()
      return allBooks.filter(book => 
        book.title.toLowerCase().includes(loweredQuery) ||
        book.author.toLowerCase().includes(loweredQuery) ||
        book.publisher.toLowerCase().includes(loweredQuery)
      )
    }
    books.value = allBooks
    return allBooks
  }

  async function getBook(id) {
    const book = books.value.find(b => b.id === parseInt(id))
    currentBook.value = book
    return book
  }

  async function addBook(book) {
    const allBooks = storageService.getBooks()
    const newBook = {
      ...book,
      id: Math.max(0, ...allBooks.map(b => b.id)) + 1
    }
    allBooks.push(newBook)
    storageService.saveBooks(allBooks)
    books.value = allBooks
    return newBook
  }

  async function updateBook(id, book) {
    const allBooks = storageService.getBooks()
    const index = allBooks.findIndex(b => b.id === parseInt(id))
    if (index > -1) {
      allBooks[index] = { ...book, id: parseInt(id) }
      storageService.saveBooks(allBooks)
      books.value = allBooks
    }
  }

  async function deleteBook(id) {
    const allBooks = storageService.getBooks()
    const index = allBooks.findIndex(b => b.id === parseInt(id))
    if (index > -1) {
      allBooks.splice(index, 1)
      storageService.saveBooks(allBooks)
      books.value = allBooks
    }
  }

  return {
    books,
    currentBook,
    fetchBooks,
    getBook,
    addBook,
    updateBook,
    deleteBook
  }
}) 