# go-mysql-crud
Sample crud operation using Golang ‘post’ Microservice and a MySQL database. This tutorial will pull a MySQL chart as it's dependency and deploy it with the application into a Kubernetes cluster. MySQL can be it's own pipeline in Guide-Rails® which builds and tests MySQL version(s), but for this example it imports a public chart. An example of pulling in the chart as an dependency which can be viewed in the 'Packages' section under the 'post' Microservice Build segment.


![ChartDependency](/img/chart_dependency.png)

Tasks defined in the Build segment demonstrate some common build tasks for building artifacts and tasks in deployment segments (Isolation, Integration, Release, or Production) are tasks which will test 'post' microservice after deployment.

The Isolation segment demonstrates deploying to the cluster using kube DNS for service registration, discovery and an ingress (public DNS) to hit the application. The Integration segment demonstrates ephemeral test enviroment for a specific run using consul for service registration, discovery. These configurations can be viewed in the segment's instance group configuration.

**Note 1**: This pipeline has defined secret properties and the following *secret properties* need to be defined at the **component level**

![CompoentLevel](/img/component_level.png)

Any property defined at branch level and below (e.g. segment/job level) are plan text and source code controled
    
    * db_root_password
    * db_user
    * db_user_password


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


