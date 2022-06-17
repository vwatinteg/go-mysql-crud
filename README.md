# go-mysql-crud
Sample crud operation using Golang and MySQL. This tutorial will pull a MySQL chart as it's dependency and deploy it with the application into a Kubernetes cluster. An example of pulling in the chart as an dependency can be viewed in the 'Packages' section under the Build segment.

![ChartDependency](/img/chart_dependency.png)

The Isolation segment demonstrates deploying to the cluster using kube DNS for service communication and an ingress to hit the application. The Integration segment demonstrates deployment using consul for service communication. These configurations can be viewed in the segment's instance group configuration.

**Note 1**: This pipeline has defined secret properties and the following *secret properties* need to be defined at the **component level**

![CompoentLevel](/img/component_level.png)

Secrets defined on the branch level will be written to the ci/guide-rails.json file **IN THE CLEAR**
    
    * db_root_password
    * db_user
    * db_user_password

**Note 2**: if you are onboarding the pipeline and deploying to a Guide-Rails® provisioned cluster, the segment will pass as a Guide-Rails® provisioned cluster will have consul installed already. If the deployment is going into a non Guide-Rails® provisioned cluster, the segment will fail.



## API ENDPOINTS

### All Posts
- Path : `/posts`
- Method: `GET`
- Response: `200`

### Create Post
- Path : `/posts`
- Method: `POST`
- Fields: `title, content`
- Response: `201`

### Details a Post
- Path : `/posts/{id}`
- Method: `GET`
- Response: `200`

### Update Post
- Path : `/posts/{id}`
- Method: `PUT`
- Fields: `title, content`
- Response: `200`

### Delete Post
- Path : `/posts/{id}`
- Method: `DELETE`
- Response: `204`

## Required Packages
- Database
    * [MySql](https://github.com/go-sql-driver/mysql)
- Routing
    * [chi](https://github.com/go-chi/chi)


