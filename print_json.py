import json

# Sample data structure: [{"col1": "A", "col2": "B", "col3": "C", "col4": "D"}, ...]
def json_to_latex(file_path):
    try:
        with open(file_path, 'r') as f:
            data = json.load(f)

        print(r"\begin{tabular}{|l|l||l|l|}")
        print(r"\hline")
        # print(type(data))
        variables = data["variables"]
        # Iterating through the list of dictionaries
        for i in range(0, len(variables), 2):
            # Join values with the LaTeX separator '&'
            row = variables[i]["name"] + " & " + variables[i]["expression"] + " & " + variables[i + 1]["name"] + " & " + variables[i + 1]["expression"] + "     \\\\ " 
            print(row)

        print(r"\hline")
        print(r"\end{tabular}")

    except FileNotFoundError:
        print("Error: The file was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

# Usage
json_to_latex('volleyball.json')