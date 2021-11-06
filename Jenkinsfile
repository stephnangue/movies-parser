def imageName = 'stephnangue/movies-parser'

node('workers'){
    stage('Checkout'){
        checkout scm
    }

    stage('Quality Tests'){
        def imageTest= docker.build("${imageName}-test", "-f Dockerfile.test .")
            imageTest.inside{
            sh 'golint'
        } 
    }

}