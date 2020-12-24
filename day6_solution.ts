import { readFileSync } from 'fs';

//split forms into families
const customsForms = readFileSync('day6_given-customs_forms.txt','utf8');
var splitForms = customsForms.split('\n\n');

function checkAnyone(listOfForms) {
    let sumOfUniques = 0;
    
    for(let i=0; i < listOfForms.length; i++) {
	let singleLine = listOfForms[i].replace(/\r?\n|\r/g, '');
	let uniqueOnly = singleLine.split('').filter(function(item, i, ar){ return ar.indexOf(item) === i; }).join('');
	sumOfUniques = sumOfUniques + uniqueOnly.length;
	//console.log(uniqueOnly + " : " + uniqueOnly.length);
    }
    return sumOfUniques;
}

function checkEveryone(listOfForms) {
    let sumOfMatches = 0;
    
    for(let i=0; i < listOfForms.length; i++) {
	let familyMembers = listOfForms[i].split('\n');
	
	//clean the final UNIX newline
	if(familyMembers[familyMembers.length-1] == "") {
	    familyMembers.splice(-1,1);
	}
	//a-z matches
	let familyMatches = Array(26).fill(true);
	
	
	//for each family member
	for(let j=0; j < familyMembers.length; j++) {
	    let familyMatchesTemp = Array(26).fill(false);
	    
	    //for every character
	    for(let k=0; k < familyMembers[j].length; k++) {
		if(familyMatches[familyMembers[j].charAt(k).charCodeAt(0) - 'a'.charCodeAt(0)]) {
		    familyMatchesTemp[familyMembers[j].charAt(k).charCodeAt(0) - 'a'.charCodeAt(0)] = true;
		}
	    }
	    familyMatches = [...familyMatchesTemp];
	}
	
	let totalMatches = 0;
	for(let j=0; j < 26; j++) {
	    if (familyMatches[j]) {
		//console.log(String.fromCharCode(j + 97));
		totalMatches++;
	    }
	}
	
	sumOfMatches += totalMatches;
    }
    return sumOfMatches;
}
    
console.log("Puzzle 1: " + checkAnyone(splitForms) + " is the sum of all customs forms \'yes\' responses.");
console.log("Puzzle 2: " + checkEveryone(splitForms) + " is the sum of each family's customs forms \'yes\' responses.");
