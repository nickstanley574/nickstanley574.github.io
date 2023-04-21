---
permalink: /resume/
layout: default
title: Resume
style: resume
---
<style>

.button {
  width: 8em;
  background-color: #f5f5f5;
  border-style: solid;
  border-width: 2px;
  padding: 3px 7px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  cursor: pointer;
  border-radius: 10px;
  font-size: 84%;
}

.button:hover {
    background-color: #0B3F62;
    color: white;
    text-decoration: none;
}

/* Create two equal columns that floats next to each other */
.column {
    float: left;
    width: 50%;
    text-align: center
}

.row {
    margin-block-start: 0em;
    margin-block-end: 0em;  
    display: flex;
    align-items: center;
    justify-content: center;  
}

body {
  line-height: 1.4em; 
}

li {
  padding-bottom: 7px
}

</style>

<div class="row">
  <div class="column">
        <a class="button" href="/assets/NicholasStanleyResume.pdf" target="_blank">PDF Version <i class="bi bi-file-pdf-fill"></i></a>
  </div>
  <div class="column">
        <a class="button" href="https://www.linkedin.com/in/nickstanley574/" target="_blank">LinkedIn <i class="bi bi-linkedin"></i></a>
  </div>
  <div class="column">
        <a class="button" href="https://github.com/nickstanley574" target="_blank">GitHub <i class="bi bi-github"></i></a>
  </div>
</div>

## Backstop Solutions 📈

Backstop Solutions Group is a Software-as-a-Service company, providing cloud based solutions to hedge funds, 
funds-of-funds, endowments, and other institutional investors.

{% include resume-position.html 
  title="Senior Software Engineer - DevOps"
  date="Oct 2020 - Present"
%}
* {: .pdfresume} Responsible for the internal container deployment and orchestration system utilizing Ruby, Python, Nomad, Vault, Consul, Nginx, and Jenkins.
* Lead DevOps team member of the Oracle to Postgres migration project. 
* Participating in business continuity planning; Identifying single points of failure and developing procedures to ensure core business would keep functioning during worst case scenarios.
* Took on responsibilities of DevOps Manager after the former manager’s departure; One-on-Ones with team members, participated in architecture/roadmap planning, delegated ticket assignments, paired with team members to make sure they were getting the support to complete their tasks.
* Run organization wide Trouble in a Production (TPS) meetings.
* Participated in the hiring process; designed coding challenges, and interview process alongside other managers and lead engineers.
* Designed homework challenges and interview process for engineering positions and participated in the screening and interview process.
* Developing custom Jira, Jenkins, and Gitlab integrations to enforce compliance checks, security practices, and development procedures.
* Maintaining and building Continuous Integration / Continuous Delivery CICD pipelines using Nomad, Consul, Vault and Jenkins.
* Chat noise ... I mean ChatOps

{% include resume-position.html 
  title="Software Engineer - DevOps"
  date="Jun 2019 - Sep 2020"
%}

* Project Lead - Migrated testing system from a persistence to On-Demand model, increasing productivity and suitability while reducing costs.
* Developed a EC2 instance backup restore process using AWS Data Lifecycle Manger (DLM).
* Introduced AWS CLI and IAM roles to Jenkins Infrastructure to automate tasks.
* Support development process for US and China offices.
* Part of team wide effort to decompose a legacy orchestration monolithic app into microservices.
* Developed automated JIRA workflows using Adaptavist ScriptRunner.
* Collaborated with Infrastructure team to develop processes in hybrid cloud environment with brick and mortar datacenters and multiple AWS accounts.
* Responsible for Creating AWS IAM Users, Policies, Groups etc.
* Provisioning of AWS service resources including EC2, VPC, EBS, AMI, S3 buckets.
* Perform security assessments and implement remediations.
* Created auto auditing scripts that searched for orphaned resources on AWS accounts.
* Many hats: tools developer, automation engineer, cloud architect ... the list goes on.
* Developed PowerShell scripts for Windows automation.
* Developed scripts using the boto3 Python library to automate tasks and procedures. 

## Discovery Education 🌎

Discovery Education provides digital curriculum resources for classrooms worldwide with digital textbooks,multimedia content, and a professional development community.

{% include resume-position.html 
  title="Systems/DevOps Engineer"
  date="2016 - 2019"
%}

* Project Lead on configuration management software upgrades, monitoring and alerting platform migration and development of deployment system.
* Worked in and promoted a opensource first solutions culture using open source over third-party vendor build solutions.
* Part of team that created a AWS Disaster recovery POC using Terraform, EC2, RDS and Puppet.
* Managed Puppet infrastructure through major version upgrades.
* Deployed Nagios, Puppet and Elasticsearch on OpenStack using Heat.
* Perform on call duties to manage alerts on PagerDuty and solve issues.
* Automated processes using Puppet, Python-Fabric, Bash and Jenkins.
* Implemented ELK Stack with Metricbeats to collect and monitor system metrics.
* Deployed initial implementation of NGINX WAF/ModSecurity.
* Monitoring and Alerting SME;
* Co-authored Infrastructure team development model implementing Scrum concepts including story points, burn-downs, and sprints.
* Assisted the administration of Katello (Red Hat Satellite Server) that manages Linux packages, dependencies, and patches.
* Supported organization wide effort to migrating Adobe Coldfusion applications to Lucee based Docker images.

{% include resume-position.html 
  title="Systems Engineer Jr."
  date="2015 - 2016"
%}

* Responsibilities included the development and design of systems, software deployment, hardware upgrades, scripting, documentation, platform upgrades, monitoring and hardware management.
* Migrated Gluster volumes to AWS S3 using AWS Snowball.
* Maintained the SDLCs for Coldfusion/Lucee, Meteor, and Flask web applications.
* Redesigned and deployed Nagios implementation using Puppet.
* Configured the intrusion prevention software Fail2Ban to prevent brute force attacks.
* Supported content publishing pipeline using S3, Handbrake, Gluster, and Cyberduck.
* Analyzed and resolved merge conflicts in Git and SVN.

{% include resume-position.html 
  title="Intern Systems & Infrastructure"
  date="Summer 2015"
%}

* Installed, upgraded, and configured CentOS 6.x, and 7.x nodes.
* Developed Puppet modules and downloaded pre-written modules from Puppet Forge.
* General Linux administration on 500+ nodes in three geographic regions.
* Implemented pre-built and custom Nagios checks.
* Configured Apache and Nginx.

## DePaul University 🎓

* Master of Science - Software Engineering 2019
* Bachelor of Science - Computer Science 2016

{% include resume-position.html 
  title="Adjunct Instructor"
  date="2020 - 2021"
%}

Taught introduction into computer science courses, using the Python programming language, focusing on classes, objects, recursion,
exception handling, runtime analysis, web crawling and GUIs.Teaching intro computer science courses, using the Python programming language,
focusing on classes, objects, recursion, exception handling, runtime analysis, web crawling and GUIs.



{% include resume-position.html 
  title="Technical Support"
  date="2013 - 2016"
%}

Responsible for imaging and deployment of faculty work stations and lab machines, as well as, providing technical support to both faculty and students.

{% include resume-position.html 
  title="Graduate Assistant | Tutor"
  date="2016 - 2019"
%}

Tutored undergraduate and graduate students in the following subjects and concepts: Java and Python syntax and structure, Introduction into Computer Science, Data Structures, Sorting Algorithms, Object Oriented Design Patterns, Introductory SQL,Bash, and Basic Linux administration and configuration.

{% include resume-position.html 
  title="Course Assistant | Grader"
  date="2015 - 2016"
%}

Evaluated and provided feedback to students' solutions While communicating with professors regarding expectations, course polices, homework assignments and solutions.

### Scholarships
* Warren Krueger & Ronnveig Ernst Computer Science Scholarship
* St. Vincent de Paul Scholarship
* DePaul Leadership Scholarship

## Early Summer Jobs 🚜

{% include resume-position.html 
  title="Clearwater Camp | Maintenance & Grounds"
  date="Summer 2013, 2014"
%}

Clearwater Camp is a American Camp Association member providing a summer camping experience for ages 8-16. During the summer lived on site and maintenance the camp grounds, cabins, equipment and vehicles.

{% include resume-position.html 
  title="Hughes Seed Farm | Corn Detasseler"
  date="Summer 2011, 2012"
%}

Farm work. Road on tractors, pulled corn tassels, and drove trucks all starting before the rooster crowed.

