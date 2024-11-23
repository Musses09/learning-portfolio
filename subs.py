#Finding a Motif in DNA
#Given: two DNA strings s and t (each of length at most 1 kbp)
#Return: all locations of t as a substring of s
# DNA strings
s = input("DNA strand:" ) # Forward strand
t = input("Motif: ")  # Motif to search for

# Function to find all locations of a motif in a DNA sequence
def find_motif_locations(s, t):
    locations = []
    motif_length = len(t)
    for i in range(len(s) - motif_length + 1):  # Slide over s
        if s[i:i + motif_length] == t:  # Check if substring matches motif
            locations.append(i + 1)  # Append 1-based index
    return locations

# Reverse complement function
def reverse_complement(sequence):
    complement = {"A": "T", "T": "A", "C": "G", "G": "C"}
    reverse_sequence = "".join(complement[b] for b in sequence)[::-1]
    return reverse_sequence

# Find motif in the forward strand
forward_locations = find_motif_locations(s, t)

# Find motif in the reverse complement
reverse_s = reverse_complement(s)
reverse_locations = find_motif_locations(reverse_s, t)

# Print results
print("Motif found at positions in forward strand:", " ".join(map(str, forward_locations)))
print("Motif found at positions in reverse complement strand:", " ".join(map(str, reverse_locations)))
