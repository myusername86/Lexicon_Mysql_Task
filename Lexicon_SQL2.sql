# SQL Join exercise
USE world;
select * from city;
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
select Name,Population from city where Name LIKE 'ping%' ORDER BY Population ASC;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
select Name,Population from city where Name LIKE 'ran%' ORDER BY Population DESC;

# 3: Count all cities

select count(*)  as CityCount from city;
# 4: Get the average population of all cities

select avg(Population) as AVG_Population from city;
# 5: Get the biggest population found in any of the cities

select max(Population) from city;
#
# 6: Get the smallest population found in any of the cities

select min(Population) from city;
# 7: Sum the population of all cities with a population below 10000
#
select SUM(Population) from city where Population < 10000;
# 8: Count the cities with the countrycodes MOZ and VNM
select count(*) from city where CountryCode IN ('MOZ','VNM');


# 9: Get individual count of cities for the countrycodes MOZ and VNM
select count(*) from city where CountryCode IN('MOZ','VNM');

# 10: Get average population of cities in MOZ and VNM
select AVG(Population) from city where CountryCode IN('MOZ','VNM');

# 11: Get the countrycodes with more than 200 cities
select CountryCode from city group by CountryCode HAVING COUNT(*)>200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count

select CountryCode,count(*) as city_count from city GROUP BY CountryCode HAVING Count(*)>200 order by city_count DESC;
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

select c.Name,l.Language from city c JOIN countrylanguage l on c.CountryCode=l.CountryCode where c.Population BETWEEN 400 AND 500;
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
select c.Name,l.Language from city c JOIN countrylanguage l on c.CountryCode=l.CountryCode where Population BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
select c.Name,c.Population,d.Population,d.Name from city c JOIN country d on c.CountryCode=d.Code where c.CountryCode=(select CountryCode from city where Population=122199);


# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT city.Name
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.CountryCode = (
    SELECT city.CountryCode
    FROM city
    WHERE city.Population = 122199
)
AND city.Population != 122199;


#
# 17: What are the city names in the country where Luanda is capital?
select c.Name,d.Code from city c JOIN country d on c.CountryCode=d.Code where d.Capital=(select ID from city where Name='Luanda');


# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
select c.Name,d.Code from city c JOIN country d on c.CountryCode=d.Code where d.Capital=(select ID from city where Name='Yaren');

# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT cl.Language
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
WHERE c.Region = (
    SELECT c2.Region
    FROM city ci
    JOIN country c2 ON ci.CountryCode = c2.Code
    WHERE ci.Name = 'Riga'
);




# 20: Get the name of the most populous city
select Name from city order by Population desc;

select Name from city order by Population desc LIMIT 1;
#
