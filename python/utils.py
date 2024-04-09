import os
import subprocess
import csv
import matplotlib.pyplot as plt


def hsv_to_rgb(hsv):
    h, s, v = hsv
    hi = (h / 60) % 6
    f = (h / 60) - hi 
    p = v * (1 - s)
    q = v * (1 - f * s)
    t = v * (1 - (1 - f) * s)
    rgb = [
        [v, t, p],
        [q, v, p],
        [p, v, t],
        [p, q, v],
        [t, p, v],
        [v, p, q]
    ]
    if hi <= 5:
        return rgb[round(hi)]
    else:
        return [0,0,0]
    

def generate_rgb_color_palette(count, sat, value):
    hsv_colors = [[ h * (360 / count), sat, value] for h in range(0, count)]
    return [hsv_to_rgb(hsv) for hsv in hsv_colors]


def compile_binary_program():
    make_command = ['make', 'VERBOSE=true']
    try:
        subprocess.run(make_command, check=True)
        return True
    except subprocess.CalledProcessError:
        return False


def analyzeInstance(config):
    binary_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', config['binary_name']))
    process = subprocess.Popen([binary_path], '-a', '-p', config['model_file'])
    stderr_output = process.communicate()[1]
    if stderr_output:
        print('Error:', stderr_output.decode())
        return False
    return True


def run_binary_program(config, clearLog):
    binary_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', config['binary_name']))

    with open(config['log_file'], 'a') as log:
        process = subprocess.Popen([binary_path, 
                                    '-p', config['model_file'], 
                                    '-o', config['output_file'],
                                    '-d', config['distances_file'],
                                    '-g', config['production_gross'],
                                    '-l', config['gross_tolerance'],
                                    '-t', config['timeout'],
                                    '-i', config['iterations']
                                    ], stdout=log, stderr=subprocess.PIPE)
        stderr_output = process.communicate()[1]
        log.write("\n\n")

        if clearLog:
            os.remove(config['log_file'])
    
        if stderr_output:
            print('Error:', stderr_output.decode())
            return False
    
    return True


def plot_csv(config):

    dominated_production_loss = []
    dominated_travel_cost = []
    non_dominated_production_loss = []
    non_dominated_travel_cost = []

    with open(config['output_file'], 'r') as file:
        csv_reader = csv.reader(file)
        next(csv_reader)  # Skip the header row

        for row in csv_reader:
            production_loss = float(row[0])
            travel_cost = float(row[1])
            dominated = row[2]
            if dominated == 'yes':
                dominated_production_loss.append(production_loss)
                dominated_travel_cost.append(travel_cost)
            else:
                non_dominated_production_loss.append(production_loss)
                non_dominated_travel_cost.append(travel_cost)
            
    if config['show_dominated']:
        plt.scatter(dominated_production_loss, dominated_travel_cost, s=5, color='red')

    plt.plot(
        non_dominated_production_loss, 
        non_dominated_travel_cost, 
        color=config['pareto_figure_color'], 
        label=config['label_name'],
        marker='o', 
        markersize=5, 
        linewidth=3
    )
    plt.legend(loc="upper right")
    plt.xlabel('Production loss m³/day')
    plt.ylabel('Travel cost')
    plt.title('Pareto front')
    plt.grid(True)

    if config['save_fig']:
        print("Saving figure", config['pareto_figure_name'])
        plt.savefig(config['pareto_figure_name'])
    else: 
        if config['show_fig']:
            plt.show()

    if config['remove_data']:
        os.remove(config['output_file'])
