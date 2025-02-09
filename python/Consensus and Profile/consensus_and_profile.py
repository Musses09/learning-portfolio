from collections import defaultdict

def parse_fasta_file(file_path):
    """Parse a FASTA file and return a list of DNA sequences."""
    sequences = []
    current_sequence = []
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if line.startswith(">"):
                if current_sequence:
                    sequences.append("".join(current_sequence))
                    current_sequence = []
            else:
                current_sequence.append(line)
        if current_sequence:
            sequences.append("".join(current_sequence))
    return sequences

def build_profile_matrix(sequences):
    """Build the profile matrix as a dictionary."""
    length = len(sequences[0])
    profile = {'A': [0] * length, 'C': [0] * length, 'G': [0] * length, 'T': [0] * length}
    for sequence in sequences:
        for i, nucleotide in enumerate(sequence):
            profile[nucleotide][i] += 1
    return profile

def consensus_string(profile):
    """Determine the consensus string from the profile matrix."""
    consensus = []
    for i in range(len(profile['A'])):
        max_base = max('ACGT', key=lambda x: profile[x][i])
        consensus.append(max_base)
    return ''.join(consensus)

# Input: Path to the `rosalind_cons.txt` file
file_path = "/home/jovyan/rosalind/rosalind_cons.txt"
  # Ensure this matches your file's actual name and location

# Step 1: Parse the FASTA file
sequences = parse_fasta_file(file_path)

# Step 2: Build the profile matrix
profile = build_profile_matrix(sequences)

# Step 3: Determine the consensus string
consensus = consensus_string(profile)

# Output
print("Consensus:", consensus)

