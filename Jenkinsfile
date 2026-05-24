pipeline {
    agent any
    
    environment {
        // 智谱 API Key
        ZHIPU_API_KEY = credentials('zhipu-api-key')
    }
    
    stages {
        stage('AI Code Review') {
            steps {
                script {
                    sh '''
                        # 获取代码变更
                        git diff origin/main...HEAD | curl https://open.bigmodel.cn/api/paas/v4/chat/completions \
                        -H "Authorization: Bearer $ZHIPU_API_KEY" \
                        -H "Content-Type: application/json" \
                        -d '{
                            "model": "glm-4.5",
                            "messages": [{"role": "user", "content": "请审查以下代码变更，指出安全风险和潜在bug：\n" + $(cat)}]
                        }'
                    '''
                }
            }
        }
    }
}