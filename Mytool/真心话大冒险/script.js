// 在文件开头添加调试日志
console.log('Script loaded');

const questions = [
    "你曾经暗恋过在场的人吗？是谁？",
    "你最后一次哭是什么时候？为什么？",
    "你最短的一次恋爱是什么情况？",
    "你曾经因为喜欢一个人做过什么傻事？",
    "如果让你从在场的人中选一个约会，你会选谁？",
    "你曾经撒过的最大的谎是什么？",
    "你理想中的另一半是什么样子的？",
    "你曾经看过别人的手机吗？为什么？",
    "你最喜欢的电影角色是谁？为什么？",
    "你曾经因为什么事情哭得最伤心？",
    "你希望自己现在是几岁？为什么？",
    "你曾经因为什么事情感到最羞愧？",
    "你最喜欢的明星是谁？为什么？",
    "你曾经因为什么事情感到最自豪？",
    "你最喜欢的旅行地点是哪里？为什么？",
    "你曾经因为什么事情感到最害怕？",
    "你最喜欢的节日是什么？为什么？",
    "你曾经因为什么事情感到最愤怒？",
    "你最喜欢的颜色是什么？为什么？",
    "你曾经因为什么事情感到最幸福？",
    "你最喜欢的运动是什么？为什么？",
    "你曾经因为什么事情感到最失望？",
    "你最喜欢的书籍是什么？为什么？",
    "你曾经因为什么事情感到最惊讶？",
    "你最喜欢的游戏是什么？为什么？"
];

const tasks = [
    "用屁股写自己的名字，让大家猜。",
    "对着窗外大喊：\"我好寂寞啊！\"",
    "模仿一位在场的朋友，直到有人猜出是谁。",
    "用奇怪的语调唱一首歌。",
    "给通讯录里第一个人打电话，说\"我想你了\"",
    "选一位异性朋友，对视10秒不能笑。",
    "给一位不在场的朋友发语音，说\"我有个秘密要告诉你\"",
    "选一个人，用撒娇的语气说一句话。",
    "一口气喝完一杯混合饮料（比如酱油+可乐）。",
    "原地转10圈，然后走直线。",
    "用非惯用手写一句话。",
    "做一个高难度的瑜伽动作并保持10秒。",
    "在朋友圈发一张搞怪自拍，配文\"今天真开心\"",
    "给前任发一条消息，内容由大家决定。",
    "在公共场合对陌生人说一句奇怪的话。",
    "在社交媒体上发一条状态，内容由大家决定。",
    "用口红在脸上画一个图案。",
    "用手机拍一张最丑的自拍并设为壁纸。",
    "对着镜子说\"我真帅/美\"10遍。",
    "用方言朗诵一首诗。",
    "模仿一位明星的经典动作或台词。",
    "用吸管喝一杯饮料，但不能用手拿杯子。",
    "用胶带把一只手绑起来，完成一个任务。",
    "在头上顶一本书走一圈，书不能掉。",
    "用嘴叼着一张纸传递给别人，不能用手。"
];

const allCards = [...questions, ...tasks];
let isDragging = false;
let startY = 0;
let currentY = 0;

function createNewCard(content) {
    const card = document.createElement('div');
    card.className = 'card new-card';
    card.innerHTML = `
        <div class="card-decoration"></div>
        <div class="card-inner">
            <div class="card-content">
                ${content}
            </div>
        </div>
    `;
    return card;
}

function handleStart(e) {
    isDragging = true;
    startY = e.type === 'mousedown' ? e.clientY : e.touches[0].clientY;
    currentY = startY;
}

function handleMove(e) {
    if (!isDragging) return;
    e.preventDefault();
    
    currentY = e.type === 'mousemove' ? e.clientY : e.touches[0].clientY;
    const deltaY = currentY - startY;
    
    if (deltaY < 0) {
        const card = document.querySelector('.current-card');
        card.style.transform = `translateY(${deltaY}px)`;
    }
}

function handleEnd() {
    if (!isDragging) return;
    isDragging = false;
    
    const deltaY = currentY - startY;
    const card = document.querySelector('.current-card');
    const cardStack = document.getElementById('cardStack');
    
    if (deltaY < -50) {
        card.classList.add('swiped');
        cardStack.classList.add('swiping');  // 添加堆叠动画类
        
        const randomContent = allCards[Math.floor(Math.random() * allCards.length)];
        const newCard = createNewCard(randomContent);
        cardStack.appendChild(newCard);
        
        setTimeout(() => {
            card.remove();
            newCard.classList.add('show');
            newCard.classList.add('current-card');
            setupCardListeners(newCard);
            cardStack.classList.remove('swiping');  // 移除堆叠动画类
        }, 500);
    } else {
        card.style.transform = '';
    }
}

function setupCardListeners(card) {
    // 触摸事件
    card.addEventListener('touchstart', handleStart);
    card.addEventListener('touchmove', handleMove);
    card.addEventListener('touchend', handleEnd);
    
    // 鼠标事件
    card.addEventListener('mousedown', handleStart);
    document.addEventListener('mousemove', handleMove);
    document.addEventListener('mouseup', handleEnd);
}

function createParticles() {
    const container = document.getElementById('particles');
    const particleCount = 20;

    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        
        // 随机位置
        particle.style.left = Math.random() * 100 + 'vw';
        particle.style.top = Math.random() * 100 + 'vh';
        
        // 随机大小
        const size = Math.random() * 4 + 2;
        particle.style.width = size + 'px';
        particle.style.height = size + 'px';
        
        // 随机透明度
        particle.style.opacity = Math.random() * 0.5 + 0.2;
        
        // 随机动画延迟
        particle.style.animationDelay = Math.random() * 10 + 's';
        
        container.appendChild(particle);
    }
}

// 初始化
document.addEventListener('DOMContentLoaded', () => {
    const firstCard = document.querySelector('.current-card');
    setupCardListeners(firstCard);
    createParticles();
}); 