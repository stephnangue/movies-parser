def imageName = 'stephnangue/movies-parser'

node('workers'){
    stage('Checkout'){
        checkout scm
    }

    def imageTest= docker.build("${imageName}-test", "-f Dockerfile.test .")

    stage('Quality Tests'){
        imageTest.inside{
            sh 'golint'
        } 
    }

    stage('Security Tests'){ 
        imageTest.inside('-u root:root'){
           sh 'nancy /go/src/github/stephnangue/movies-parser/Gopkg.lock'
        }
    }

}