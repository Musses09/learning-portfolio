#Mendel's First Law
#Given: Three positive integers k, m, and n, representing a population containing k+m+n organisms: k individuals are homozygous dominant for a factor, m are heterozygous, and n are homozygous recessive.
#Return: The probability that two randomly selected mating organisms will produce an individual possessing a dominant allele (and thus displaying the dominant phenotype). Assume that any two organisms can mate.

k = int(input("k value is : "))   # Homozygous dominant (AA)
m = int(input("m value is : "))    # Heterozygous (Aa)
n = int(input("n value is : "))    # Homozygous recessive (aa)

#comb(n, k) function in Python calculates the number of ways to choose k items from a set of n items, without regard to the order of selection.
from math import comb

def dominant_phenotype_probability(k, m, n):
    # Total population
    total_population = k + m + n
    
    # Calculate the total number of ways to choose 2 organisms from the population
    total_pairs = comb(total_population, 2)
    
    # Calculate the number of ways to select each pair
    # AA x AA
    prob_AA_AA = comb(k, 2) / total_pairs
    # AA x Aa
    prob_AA_Aa = (k * m) / total_pairs
    # AA x aa
    prob_AA_aa = (k * n) / total_pairs
    # Aa x Aa
    prob_Aa_Aa = comb(m, 2) / total_pairs
    # Aa x aa
    prob_Aa_aa = (m * n) / total_pairs
    # aa x aa
    prob_aa_aa = comb(n, 2) / total_pairs
    
    # Outcomes for each pair (probability of dominant offspring)
    outcome_AA_AA = 1.0      # 100% dominant phenotype (AA)
    outcome_AA_Aa = 1.0      # 100% dominant phenotype (AA or Aa)
    outcome_AA_aa = 1.0      # 100% dominant phenotype (Aa)
    outcome_Aa_Aa = 0.75     # 75% dominant phenotype (AA or Aa)
    outcome_Aa_aa = 0.5      # 50% dominant phenotype (Aa)
    outcome_aa_aa = 0.0      # 0% dominant phenotype (aa)
    
    # Total probability of dominant offspring
    total_prob = (prob_AA_AA * outcome_AA_AA +
                  prob_AA_Aa * outcome_AA_Aa +
                  prob_AA_aa * outcome_AA_aa +
                  prob_Aa_Aa * outcome_Aa_Aa +
                  prob_Aa_aa * outcome_Aa_aa +
                  prob_aa_aa * outcome_aa_aa)
    
    return total_prob



probability = dominant_phenotype_probability(k, m, n)
print(f"The probability of producing a dominant phenotype is: {probability:.5f}")
