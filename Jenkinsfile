pipeline {
  agent any
  stages {
    stage('update submodule') {
      steps {
        sh '''pwd
ls
git submodule update
'''
      }
    }

    stage('build') {
      steps {
        sh 'docker build . -t blog'
      }
    }

    stage('run') {
      steps {
        sh '''
# 当container.api不存在时，返回true保证状态正常
docker rm -f blog || true 
docker run -d --name blog -p 4000:4000 -v ~/logs:/root/logs --restart always blog
sleep 1
docker logs blog
'''
      }
    }

  }
}