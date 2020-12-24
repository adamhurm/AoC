#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct BagRule {
  char color[24];
  int count;
  struct BagRule *contains[4];
};


void printBagRule(struct BagRule *rule) {
  printf("Color: %s / Count: %d", rule->color, rule->count);
  if(rule->contains != NULL) {
    for(int i=0; i<4; i++) {
      if(rule->contains[i] != NULL) {
	struct BagRule *nested_rule = rule->contains[i];
	printf("\n==>\t");
	printBagRule(nested_rule);
      }
    }
  }
  else {
    printf("\n");
  }
}

void testBagRule() {
  //vibrant blue bags contain 4 dark crimson bags, 2 clear indigo bags, 2 pale lime bags.
  struct BagRule *rule = malloc(sizeof(struct BagRule));
  strcpy(rule->color, "vibrant blue");
  rule->count = 1;

  struct BagRule *sub_rule1 = malloc(sizeof(struct BagRule));
  strcpy(sub_rule1->color, "dark crimson");
  sub_rule1->count = 4;

  struct BagRule *sub_rule2 = malloc(sizeof(struct BagRule));
  strcpy(sub_rule2->color, "clear indigo");
  sub_rule2->count = 2;

  struct BagRule *sub_rule3 = malloc(sizeof(struct BagRule));
  strcpy(sub_rule3->color, "pale lime");
  sub_rule3->count = 2;

  rule->contains[0] = sub_rule1;
  rule->contains[1] = sub_rule2;
  rule->contains[2] = sub_rule3;
  
  printBagRule(rule);
}

int main() {
  FILE *ptr_file;
  char buf[1000];

  ptr_file = fopen("day7_given-luggage_rules.txt","r");
  if (!ptr_file)
    return 1;

  int currline = 0;
  
  while (fgets(buf,1000, ptr_file)!=NULL) {
    //printf("%s",buf);

    char color_split_keyword[] = " bags";
    char *color_string_ptr = strstr(buf, color_split_keyword);
    int color_string_length = color_string_ptr - buf;

    char color_string[color_string_length+1];
    strncpy(color_string, buf, color_string_length); 
    color_string[color_string_length] = '\0';
    
    currline++;

    //printf("%s\n", color_string);
  }

  //testBagRule();
  
  fclose(ptr_file);
  return 0;
}
