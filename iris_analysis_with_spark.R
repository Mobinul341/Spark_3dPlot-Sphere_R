#libraries we need for this task
library(dplyr)
library(ggplot2)
library(sparklyr)
library(rgl)

#(i) spark connect with iris dataset
#spark_install()
sc <- spark_connect(master="local")
iris <- copy_to(sc, iris)
src_tbls(sc)


#(ii)Select variable-1,2 and last. Then order by variable 1 and group by last variable  
iris_data <-iris %>% 
  select(sepal_length, sepal_width, variety) %>%  #select variable 1,2 and last
  arrange(desc(sepal_length)) %>% #order by variable 1
  group_by(variety) %>% #group by last variable
  
  #(iii) statistical summary of all variable
  summarise_all(mean) %>% 
  
  #(iv) Multiply variable 1 by 100 and store it in another column named n1varM100
  mutate(n1varM100 = sepal_length*100) 


#(v) 3d plot using variable 1,2,3 and color them using the last variable

colors = c("red", "blue", "green")
colors <- as.numeric(iris$Species)

plot3d(iris[,1:3], col=colors)

#(vi) Modify points of 3d plot into the sphere having radius 0.1 and background color white

open3d()
spheres3d(iris[,1:3], radius = 0.1, color=colors)













