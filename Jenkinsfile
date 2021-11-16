def imageName = 'stephnangue/movies-parser'
def registry = '982039600869.dkr.ecr.eu-central-1.amazonaws.com/stephnangue/movies-parser'
def credentials = 'ecr:eu-central-1:jenkins_aws_id'

node('workers'){
    stage('Checkout'){
        checkout scm
    }

    def imageTest= docker.build("${imageName}-test", "-f Dockerfile.test .")

    stage('Pre-integration Tests'){
        parallel(
            'Quality Tests': {
                imageTest.inside{
                    sh 'golint'
                } 
            },
            'Security Tests': {
                imageTest.inside('-u root:root'){
                    sh 'nancy /go/src/github/stephnangue/movies-parser/Gopkg.lock'
                }
            }
        )
    }

    stage('Build'){
        docker.build(imageName)
    }

    stage('Push'){
        docker.withRegistry("https://"+"${registry}","${credentials}") {
            docker.image(imageName).push(commitID())

            if (env.BRANCH_NAME == 'develop') {
                docker.image(imageName).push('develop')
            }
        }    
    }

    stage('Deploy'){
        if(env.BRANCH_NAME == 'develop'){
            build job: "watchlist-deployment/${env.BRANCH_NAME}"
        }
    }
}

def commitID() {
    sh 'git rev-parse HEAD > .git/commitID'
    def commitID = readFile('.git/commitID').trim()
    sh 'rm .git/commitID'
    commitID
}