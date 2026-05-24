pipeline {
    agent any
    
    environment {
        ZHIPU_API_KEY = credentials('zhipu-api-key')
    }
    
    stages {
        stage('AI Code Review') {
            steps {
                script {
                    sh '''
                        # 获取代码变更
                        DIFF=$(git diff origin/main...HEAD 2>/dev/null || git diff HEAD^ HEAD)
                        
                        if [ -z "$DIFF" ]; then
                            echo "没有代码变更需要审查"
                            exit 0
                        fi
                        
                        # 使用临时文件构造 JSON
                        cat > /tmp/review.json <<EOF
                        {
                            "model": "glm-4-plus",
                            "messages": [
                                {
                                    "role": "user", 
                                    "content": "请审查以下代码变更，指出安全风险和潜在bug：\\n\\n$DIFF"
                                }
                            ]
                        }
                        EOF
                        
                        # 发送请求
                        curl -s https://open.bigmodel.cn/api/paas/v4/chat/completions \
                            -H "Authorization: Bearer $ZHIPU_API_KEY" \
                            -H "Content-Type: application/json" \
                            -d @/tmp/review.json
                    '''
                }
            }
        }
    }
}