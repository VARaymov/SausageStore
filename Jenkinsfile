pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Ваши шаги сборки проекта
                
                // Добавляем шаг для выполнения команды curl
                sh '''
                    curl -X POST -H "Content-type: application/json" \
                    --data '{"chat_id":"-1001634310929", "text":"Rayumov Valery sobral prilozhenie."}' \
                    "https://api.telegram.org/bot5933756043:AAE8JLL5KIzgrNBeTP5e-1bkbJy4YRoeGjs/sendMessage"
                '''
            }
        }
        // Другие этапы вашего пайплайна...
    }
}
