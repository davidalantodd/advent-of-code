<?php 

$fileData = file('data.txt');

$listA = [];
$listB = [];

foreach($fileData as $line){
    // echo $line;
    $numbers = explode("   ", $line);
    $listA[] = trim($numbers[0]);
    $listB[] = trim($numbers[1]);
}

sort($listA);
sort($listB);

// part 1

$distance = 0;

for ($i = 0; $i < count($listA); $i++){
    $distance += abs($listA[$i] - $listB[$i]);
}

// part 1 solution

print('part 1: ' . (string)$distance . "\n");

// part 2

/* go through second list and create a map 
to determine number of times each number appears */

$map = new stdClass();

foreach($listB as $number){
    if (!property_exists($map, $number)){
        $map->$number = 1;
    } else {
        $map->$number ++;
    }
}

// calculate similarity score

$similarityScore = 0;

foreach($listA as $number){
    if (property_exists($map, $number)){
        $similarityScore += ($map->$number * $number);
    }
}

// part 2 solution

print_r('part 2: ' . (string) $similarityScore . "\n");