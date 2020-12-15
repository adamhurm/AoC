import { readFileSync } from 'fs';

const customsForms = readFileSync('day6_given-customs_forms.txt','utf8');

var splitForms = customsForms.split('\n\n');

function checkTotalUniqueChars(listOfForms) {
    var sumOfUniques = 0;
    for(var i=0; i < listOfForms.length; i++) {
	var singleLine = listOfForms[i].replace(/\r?\n|\r/g, '');
	var uniqueOnly = singleLine.split('').filter(function(item, i, ar){ return ar.indexOf(item) === i; }).join('');
	sumOfUniques = sumOfUniques + uniqueOnly.length;
	//console.log(uniqueOnly + " : " + uniqueOnly.length);
    }
    return sumOfUniques;
}

function checkFamilyUniqueChars(listOfForms) {
    var sumOfMatches = 0;
    for(var i=0; i < listOfForms.length; i++) {
	var familyMembers = listOfForms[i].split('\n');
	var matches = "";
	for(var j=0; j < familyMembers.length-1; j++) {
	    matches = compareStrings(familyMembers[j], familyMembers[j+1], matches);
	    sumOfMatches = sumOfMatches + matches.length;
	}
	console.log("\n\n");
    }
}

function compareStrings(s1, s2, currentMatches) {
    var shortStr;
    var longStr;

    if(s1.length < s2.length) {
	shortStr = s1;
	longStr = s2;
    } else {
	shortStr = s2;
	longStr = s1;
    }

    for(let i = 0; i < shortStr.length; i++) {
	if(longStr.indexOf(shortStr[i]) !== -1) {
	    currentMatches = currentMatches + shortStr[i];
	}
    }
    console.log(s1 + "||" + s2 + " : " + currentMatches);
    return currentMatches;
}

console.log("Puzzle 1: " + checkTotalUniqueChars(splitForms) + " is the sum of all customs forms \'yes\' responses.");
//console.log("Puzzle 2: " + checkFamilyUniqueChars(splitForms) + " is the sum of each family's customs forms \'yes\' responses.");
