class ImageCompressor {
    constructor() {
        this.initializeElements();
        this.bindEvents();
        this.images = new Map(); // 存储待处理的图片
        this.compressedImages = new Map(); // 存储压缩后的图片
    }

    initializeElements() {
        // 获取DOM元素
        this.uploadZone = document.getElementById('upload-zone');
        this.fileInput = document.getElementById('file-input');
        this.selectButton = document.getElementById('select-files');
        this.settingsPanel = document.getElementById('settings-panel');
        this.previewContainer = document.getElementById('preview-container');
        this.downloadPanel = document.getElementById('download-panel');
        this.qualitySlider = document.getElementById('quality');
        this.qualityValue = document.getElementById('quality-value');
        this.formatSelect = document.getElementById('format');
        this.maxWidth = document.getElementById('max-width');
        this.compressionMode = document.getElementById('compression-mode');
        this.downloadAllButton = document.getElementById('download-all');
    }

    bindEvents() {
        // 绑定事件处理器
        this.uploadZone.addEventListener('dragover', this.handleDragOver.bind(this));
        this.uploadZone.addEventListener('dragleave', this.handleDragLeave.bind(this));
        this.uploadZone.addEventListener('drop', this.handleDrop.bind(this));
        this.selectButton.addEventListener('click', () => this.fileInput.click());
        this.fileInput.addEventListener('change', this.handleFileSelect.bind(this));
        this.qualitySlider.addEventListener('input', () => {
            this.updateQualityValue();
            this.handleSettingsChange();
        });
        this.downloadAllButton.addEventListener('click', this.downloadAll.bind(this));

        // 监听压缩设置变化
        const settings = [this.formatSelect, this.maxWidth, this.compressionMode];
        settings.forEach(setting => {
            setting.addEventListener('change', this.handleSettingsChange.bind(this));
        });
    }

    handleDragOver(e) {
        e.preventDefault();
        this.uploadZone.classList.add('drag-over');
    }

    handleDragLeave(e) {
        e.preventDefault();
        this.uploadZone.classList.remove('drag-over');
    }

    handleDrop(e) {
        e.preventDefault();
        this.uploadZone.classList.remove('drag-over');
        const files = Array.from(e.dataTransfer.files).filter(file => file.type.startsWith('image/'));
        this.processFiles(files);
    }

    handleFileSelect(e) {
        const files = Array.from(e.target.files);
        this.processFiles(files);
    }

    async processFiles(files) {
        this.settingsPanel.classList.remove('hidden');
        this.previewContainer.classList.remove('hidden');
        this.downloadPanel.classList.remove('hidden');

        for (const file of files) {
            if (!this.images.has(file.name)) {
                this.images.set(file.name, file);
                await this.createImagePreview(file);
                await this.compressImage(file);
            }
        }
    }

    async createImagePreview(file) {
        const template = document.getElementById('image-preview-template');
        const clone = template.content.cloneNode(true);
        const container = clone.querySelector('.image-preview');
        
        // 设置文件名
        container.querySelector('.filename').textContent = file.name;
        
        // 添加删除按钮事件
        container.querySelector('.delete-image').addEventListener('click', () => {
            this.deleteImage(file.name, container);
        });
        
        // 设置原始图片预览
        const originalImg = clone.querySelector('.original-image img');
        originalImg.src = URL.createObjectURL(file);
        
        // 显示原始图片信息
        clone.querySelector('.original-size').textContent = this.formatFileSize(file.size);
        
        // 获取图片尺寸
        const dimensions = await this.getImageDimensions(file);
        clone.querySelector('.original-dimensions').textContent = 
            `${dimensions.width} x ${dimensions.height}`;

        this.previewContainer.appendChild(container);
        return container;
    }

    async compressImage(file) {
        try {
            const options = {
                maxSizeMB: 1,
                maxWidthOrHeight: parseInt(this.maxWidth.value) || 1920,
                useWebWorker: true,
                quality: this.qualitySlider.value / 100,
                fileType: this.formatSelect.value === 'auto' ? undefined : `image/${this.formatSelect.value}`
            };

            const compressedFile = await imageCompression(file, options);
            this.compressedImages.set(file.name, compressedFile);

            // 更新压缩后的预览
            const container = this.previewContainer.lastElementChild;
            const compressedImg = container.querySelector('.compressed-image img');
            compressedImg.src = URL.createObjectURL(compressedFile);

            // 更新压缩信息
            container.querySelector('.compressed-size').textContent = 
                this.formatFileSize(compressedFile.size);
            container.querySelector('.compression-ratio').textContent = 
                this.calculateCompressionRatio(file.size, compressedFile.size);

            const dimensions = await this.getImageDimensions(compressedFile);
            container.querySelector('.compressed-dimensions').textContent = 
                `${dimensions.width} x ${dimensions.height}`;

        } catch (error) {
            console.error('压缩失败:', error);
        }
    }

    // 工具方法
    formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    calculateCompressionRatio(originalSize, compressedSize) {
        const ratio = ((originalSize - compressedSize) / originalSize * 100).toFixed(1);
        return `${ratio}%`;
    }

    async getImageDimensions(file) {
        return new Promise((resolve) => {
            const img = new Image();
            img.src = URL.createObjectURL(file);
            img.onload = () => {
                resolve({ width: img.width, height: img.height });
                URL.revokeObjectURL(img.src);
            };
        });
    }

    updateQualityValue() {
        this.qualityValue.textContent = `${this.qualitySlider.value}%`;
    }

    async handleSettingsChange() {
        // 当设置改变时重新压缩所有图片
        const previewContainers = document.querySelectorAll('.image-preview');
        try {
            for (const [filename, file] of this.images) {
                const options = {
                    maxSizeMB: 1,
                    maxWidthOrHeight: parseInt(this.maxWidth.value) || 1920,
                    useWebWorker: true,
                    quality: this.qualitySlider.value / 100,
                    fileType: this.formatSelect.value === 'auto' ? undefined : `image/${this.formatSelect.value}`
                };

                const compressedFile = await imageCompression(file, options);
                this.compressedImages.set(filename, compressedFile);

                // 更新压缩后的预览
                const container = Array.from(previewContainers).find(
                    container => container.querySelector('.filename').textContent === filename
                );
                if (container) {
                    const compressedImg = container.querySelector('.compressed-image img');
                    if (compressedImg.src) {
                        URL.revokeObjectURL(compressedImg.src); // 释放旧的 URL
                    }
                    compressedImg.src = URL.createObjectURL(compressedFile);

                    // 更新压缩信息
                    container.querySelector('.compressed-size').textContent = 
                        this.formatFileSize(compressedFile.size);
                    container.querySelector('.compression-ratio').textContent = 
                        this.calculateCompressionRatio(file.size, compressedFile.size);

                    const dimensions = await this.getImageDimensions(compressedFile);
                    container.querySelector('.compressed-dimensions').textContent = 
                        `${dimensions.width} x ${dimensions.height}`;
                }
            }
        } catch (error) {
            console.error('压缩过程出错:', error);
        }
    }

    async downloadAll() {
        if (this.compressedImages.size === 0) return;

        // 获取当前选择的输出格式
        const outputFormat = this.formatSelect.value;
        const file = this.compressedImages.values().next().value;
        
        // 创建下载链接
        const link = document.createElement('a');
        link.href = URL.createObjectURL(file);
        // 设置下载文件名和扩展名
        const timestamp = new Date().getTime();
        link.download = outputFormat === 'auto' 
            ? `compressed-image-${timestamp}.jpg`  // 默认使用jpg格式
            : `compressed-image-${timestamp}.${outputFormat}`;
        link.click();
        URL.revokeObjectURL(link.href);
    }

    // 添加删除图片方法
    deleteImage(filename, container) {
        // 显示确认对话框
        if (confirm('确定要删除这张图片吗？')) {
            // 从 Map 中移除图片
            this.images.delete(filename);
            this.compressedImages.delete(filename);

            // 从 DOM 中移除预览容器
            container.remove();

            // 如果没有图片了，隐藏相关面板
            if (this.images.size === 0) {
                this.settingsPanel.classList.add('hidden');
                this.previewContainer.classList.add('hidden');
                this.downloadPanel.classList.add('hidden');
            }

            // 释放图片资源
            const originalImg = container.querySelector('.original-image img');
            const compressedImg = container.querySelector('.compressed-image img');
            if (originalImg.src) URL.revokeObjectURL(originalImg.src);
            if (compressedImg.src) URL.revokeObjectURL(compressedImg.src);
        }
    }
}

// 初始化应用
document.addEventListener('DOMContentLoaded', () => {
    new ImageCompressor();
}); 