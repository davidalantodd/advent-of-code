<?php

$fileData = file('data.txt');

$safeLevels = 0;
$safeLevelsPart2 = 0;

// part 1 helper - check if a report is safe

function checkIfSafe(array $level): bool{
    for($i = 0; $i < count($level)-1; $i++){
        $diff = $level[$i+1] - $level[$i];
        if ($diff < 1 || $diff > 3){
            return false;
        }
    }
    return true;
}

// part 2 helpers - with problem dampener (remove one level to deem report safe)

function checkAllSplicedArrays(array $level): bool {
    for ($i = 0; $i < count($level); $i++){
        $tempLevel = $level;
        array_splice($tempLevel, $i, 1);
        if (checkIfSafe($tempLevel)){
            return true;
        }
    }
    return false;
}

function checkIfSafeWithProblemDampener(array $level): bool{
    for($i = 0; $i < count($level)-1; $i++){
        $diff = $level[$i+1] - $level[$i];
        if ($diff < 1 || $diff > 3){
            if (checkAllSplicedArrays($level)){
                return true;
            } else {
                return false;
            }
        }
    }
    return true;
}

// iterate through reports to check levels

foreach($fileData as $l){
    $line = explode(" ",$l);

    if (checkIfSafe($line) || checkIfSafe(array_reverse($line))){
        $safeLevels++;
    } 

    if (checkIfSafeWithProblemDampener($line) || checkIfSafeWithProblemDampener(array_reverse($line))){
        $safeLevelsPart2++;
    }
}

print_r('part 1: ' . (string)$safeLevels . "\n"); 
print_r('part 2: ' . (string)$safeLevelsPart2 . "\n");