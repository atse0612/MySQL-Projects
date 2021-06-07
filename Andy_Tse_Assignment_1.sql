
DROP DATABASE IF EXISTS `recipes`;
CREATE DATABASE  IF NOT EXISTS `recipes`;
USE `recipes`;


--
-- Table structure for table `recipe_main`
--

DROP TABLE IF EXISTS `recipe_main`;
CREATE TABLE `recipe_main` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_desc` varchar(1024) DEFAULT NULL,
  `prep_time` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `directions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_title_idx` (`rec_title`),
  KEY `prep_time_idx` (`prep_time`),
  KEY `cook_time_idx` (`cook_time`),
  KEY `difficulty_idx` (`difficulty`),
  KEY `FK_category_id_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe_main`
--

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (1,'Chicken Marsala',1,'Chicken and mushrooms',20,20,4,2,'Flatten chicken breats to 1/4 inch. Place flour in a resealable plastic bag with two pieces of chicken at a time and shake to coat.Cook chicken in olive oil in a large skillet over medium heat for 3-5 minutes on each side or until the meat reaches a temparature of 170°. Remove chicken from skillet and keep warm.Use the same skillet to saute the mushrooms in butter until tender. Add the wine, parsley and rosemary. Bring mixture to a boil and cook until liquid is reduced by half. Serve chicken with mushroom sauce; sprinkle with cheese if desired.'),(2,'Absolute Brownies',2,'Rich, chcolate brownies',25,35,16,2,'Preheat oven to 350 degrees F (175 degrees C). Grease and flour an 8 inch square pan.In a large saucepan, melt 1/2 cup butter. Remove from heat, and stir in sugar, eggs, and 1 teaspoon vanilla. Beat in 1/3 cup cocoa, 1/2 cup flour, salt, and baking powder. Spread batter into prepared pan.Bake in preheated oven for 25 to 30 minutes. Do not overcook.To Make Frosting: Combine 3 tablespoons butter, 3 tablespoons cocoa, 1 tablespoon honey, 1 teaspoon vanilla, and 1 cup confectioners sugar. Frost brownies while they are still warm.');
UNLOCK TABLES;

--
-- Table structure for table `rec_ingredients`
--

DROP TABLE IF EXISTS `rec_ingredients`;
CREATE TABLE `rec_ingredients` (
  `rec_ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`rec_ingredient_id`),
  KEY `FK_ingredient_recipe_id_idx` (`recipe_id`),
  KEY `FK_recipe_ingredient_id_idx` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (1,1,4.00,1),(2,1,2.00,2),(3,1,2.00,3),(4,1,2.00,4),(5,1,2.00,5),(6,1,0.75,6),(7,1,0.25,8),(8,1,2.00,9),(9,1,2.00,10),(10,2,0.50,3),(11,2,1.00,11),(12,2,2.00,12),(13,2,1.00,13),(14,2,0.33,14),(15,2,0.50,2),(16,2,0.25,15);
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(75) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_name_idx` (`ingred_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (1,'Chicken breast halves, boneless'),(2,'Flour'),(3,'Olive oil'),(4,'Sliced mushrooms'),(5,'Butter'),(6,'Marsala wine'),(7,'Chicken broth'),(8,'Rosemary, dried and crushed'),(9,'Parsley, minced'),(10,'Parmesan cheese, grated'),(11,'White sugar'),(12,'Egg(s)'),(13,'Vanilla extract'),(14,'Unsweetened cocoa powder'),(15,'Salt'),(16,'Baking powder'),(17,'Butter, softened'),(18,'Honey'),(19,'Sugar, confectioners');
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_name_idx` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Entree'),(2,'Desserts');
UNLOCK TABLES;

-- Adding recipes for table `recipe_main`
INSERT INTO `recipe_main` VALUES (3,'Mexican Baked Fish',3,'Hot or mild baked fish',15,15,6,1,'Preheat oven to 400 degrees F (200 degrees C). Lightly grease one
8x12 inch baking dish. Rinse fish fillets under cold water, and pat dry with paper towels.
Lay fillets side by side in the prepared baking dish. Pour the salsa over the top, and sprinkle evenly with the shredded cheese. Top with the crushed corn chips. Bake, uncovered, in the preheated oven for 15 minutes, or until fish is opaque and flakes with a fork. Serve topped with sliced avocado and sour cream.'),(4,'Slow Cooker Mediterranean Lentil Stew',4,'Warm, hearty lentil stew',20,190,10,4,'Warm water and vegetable bouillon in a slow cooker on High until dissolved. Add lentils, carrots, and potatoes. Heat a medium saucepan over medium heat. Add cumin and coriander and cook and stir until fragrant, about 20 seconds. Add oil, followed by onion. Cook, stirring occasionally, 2 to 3 minutes. Add garlic and sauté for 30 seconds. Remove from heat and transfer to the slow cooker. Stir. Add tomato paste, salt, and pepper. Stir in spinach. Cook on High, stirring every 30 minutes, until lentils are tender and stew has thickened, 3 to 4 hours. You can use 5 cups pre-made vegetable broth instead of water and bouillon.');

-- Adding ingredient counts for table `rec_ingredients` (1)
INSERT INTO `rec_ingredients` VALUES (17,3,1.50,16),(18,3,1.00,17),(19,3,1.00,18),(20,3,0.50,19),(21,3,1.00,20),(22,3,0.25,21),(23,4,5.0,22),(24,4,2.50,23),(25,4,2.00,24),(26,4,5.00,25),(27,4,2.00,26),(28,4,3.00,27),(29,4,1.00,28),(30,4,1.00,29),(31,4,1.00,30),(32,4,4.0,31),(33,4,0.5,32),(34,4,0.5,33),(35,4,0.5,34),(36,4,0.5,35);

-- Adding ingredients for table `ingredients` (1)
INSERT INTO `ingredients` VALUES (20,'Cod'),(21,'Salsa'),(22,'Sharp cheddar cheese, shredded'),(23,'Corn chips, coarsely crushed'),(24,'Avocado, peeled, pitted, and sliced'),(25,'Sour cream'),(26,'Water'),(27,'Vegetable bouillon cubes, or more to taste'),(28,'Lentils, dried'),(29,'Small carrots, peeled and diced'),(30,'Ground cumin, or to taste'),(31,'Ground coriander'),(32,'Olive oil'),(33,'Small onion, diced'),(34,'Garlic, minced'),(35,'Tomato paste, or to taste'),(36,'Sea salt, or to taste'),(37,'Freshly ground black pepper, or to taste'),(38,'Fresh spinach, torn');

-- Adding categories for table `categories` (1) 
INSERT INTO `categories` VALUES (3,'Main Dishes'),(4,'Soups');


-- Running commands to test
Select * FROM recipe_main 
Select * from rec_ingredients
Select * from ingredients
Select * from categories

-- Running query to return the two new recipes (2)
SELECT *
FROM recipe_main RM
LEFT JOIN rec_ingredients RI
ON RI.recipe_id = RM.recipe_id
LEFT JOIN ingredients I
ON I.ingredient_id = RI.ingredient_id
LEFT JOIN categories C
ON C.category_id = RM.category_id
WHERE RI.recipe_id = 3 OR RI.recipe_id = 4;

-- Selecting the recipe name, category name, ingredient name, and ingredient amount (3)
SELECT RM.rec_title, C.category_name, I.ingred_name, RI.amount
FROM recipe_main RM
LEFT JOIN rec_ingredients RI
ON RI.recipe_id = RM.recipe_id
LEFT JOIN ingredients I
ON I.ingredient_id = RI.ingredient_id
LEFT JOIN categories C
ON C.category_id = RM.category_id
ORDER BY RM.rec_title DESC, C.category_name ASC, I.ingred_name DESC;