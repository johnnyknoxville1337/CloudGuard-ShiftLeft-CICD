pipeline {
      agent any
      environment {
           CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
           CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
           SG_CLIENT_ID = credentials("SG_CLIENT_ID")
           SG_SECRET_KEY = credentials("SG_SECRET_KEY") 
        }
        
  stages {
          
         stage('Clone Github repository') {
            
    
           steps {
              
             checkout scm
           
             }
  
          }
          
    stage('ShiftLeft Code Scan') {   
       steps {   
                   
         script {      
              try {

             
                
            
                sh 'sudo chmod +x shiftleft' 

                sh 'sudo ./shiftleft code-scan -s .'
           
               } catch (Exception e) {
    
                 echo "Request for Approval"  
                  }
              }
            }
         }
         
     stage('Code approval request') {
     
           steps {
             script {
               def userInput = input(id: 'confirm', message: 'Do you Approve to use this code?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Approve Code to Proceed', name: 'approve'] ])
              }
            }
          }
           
           
          stage('webapp Docker image Build and scan prep') {
             
            steps {

              sh 'sudo -S docker build -t dhouari/webapp .'
              sh 'sudo -S docker save dhouari/webapp -o webapp.tar'
              
             } 
           }
        
           
       stage('ShiftLeft Container Image Scan') {    
           
            steps {
                script {      
              try {
         
                    sh 'sudo ./shiftleft image-scan -t 180 -i webapp.tar'
                   } catch (Exception e) {
    
                 echo "Request for Approval"  
                  }
                }  
             }
          }
            
       stage('Container image approval request') {
     
           steps {
             script {
               def userInput = input(id: 'confirm', message: 'Do you Approve to use this container image?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Approve docker image to Proceed', name: 'approve'] ])
              }
            }
          }
        
      stage('Terraform config policy Scan') {    
           
            steps {
         
                    sh 'sudo ./shiftleft iac-assessment -l S3Bucket should have encryption.serverSideEncryptionRules -p ./terraform'
                    
              }
            }
  } 
}


