import os
import re

# Function to parse elapsed times from the content of a file
def parse_file(file_path):
    elapsed_times = {}
    
    with open(file_path, 'r') as file:
        content = file.read()
        
        # Find all bit sizes and their corresponding elapsed times
        entries = re.findall(r"(\d+ bits):\s*(\d+)\s+Elapsed time:\s*([\d\.]+) seconds", content)
        
        for bit_size, prime, elapsed_time in entries:
            # Remove the " bits" part and convert to integer
            bit_size = int(bit_size.replace(' bits', ''))
            elapsed_time = float(elapsed_time)
            
            # Initialize the list if it's the first time encountering this bit size
            if bit_size not in elapsed_times:
                elapsed_times[bit_size] = []
            
            elapsed_times[bit_size].append(elapsed_time)
    
    return elapsed_times


# Function to calculate statistics (average, min, max) for each bit size
def calculate_statistics(elapsed_times):
    stats = {}
    
    for bit_size, times in elapsed_times.items():
        avg_time = sum(times) / len(times)
        min_time = min(times)
        max_time = max(times)
        
        stats[bit_size] = {
            'average': avg_time,
            'min': min_time,
            'max': max_time
        }
    
    return stats

# Main function to process all files in a folder
def process_folder(folder_path):
    all_elapsed_times = {}

    # Loop through all files in the folder
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        
        if os.path.isfile(file_path) and filename.endswith('.txt'):
            file_elapsed_times = parse_file(file_path)
            
            # Combine the results from all files
            for bit_size, times in file_elapsed_times.items():
                if bit_size not in all_elapsed_times:
                    all_elapsed_times[bit_size] = []
                all_elapsed_times[bit_size].extend(times)
    
    # Calculate the statistics for each bit size
    stats = calculate_statistics(all_elapsed_times)
    
    return stats

# Print the statistics in a readable format
def print_statistics(stats):
    print(f"{'Bit Size':<12} {'Average Time (s)':<20} {'Min Time (s)':<15} {'Max Time (s)'}")
    print("-" * 60)
    
    for bit_size in sorted(stats.keys()):
        avg_time = stats[bit_size]['average']
        min_time = stats[bit_size]['min']
        max_time = stats[bit_size]['max']
        print(f"{bit_size:<12} {avg_time:<20.2f} {min_time:<15.2f} {max_time}")

# Example usage
folder_path = 'generated_primes/isaac/ss'  # Replace with the path to your folder
stats = process_folder(folder_path)
print_statistics(stats)
