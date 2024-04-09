from utils import *

# Instance configuration
num_wells = 50 # Requires params_n.csv and distances_n.csv files replacing n with number of wells
production_gross = 1000
gross_tolerance = 25

# Tolerance sweep
tol_start = 25
tol_end = 150
tol_step = 25


config = { # Configuration parameters
    'binary_name': 'optimize', # Binary name
    'model_file': 'data/params_{}.csv'.format(num_wells), # Instance parameters file
    'distances_file': 'data/distances_{}.csv'.format(num_wells), # Instance distances file
    'output_file': 'results.csv',
    
    'pareto_figure_name': 'fig_results.png',
    'pareto_figure_color': 'green',
    
    'remove_data': True, # Remove output file after run
    'save_fig': False, # Save figure with results
    'show_fig': False, # Show figure with results
    'show_dominated': False,
    
    'log_file': 'log.txt',
    'production_gross': str(production_gross),
    'gross_tolerance': str(gross_tolerance),
    'timeout': '15',
    'iterations': '1000000'
}


if __name__ == '__main__':
    # Compile binary
    if not compile_binary_program():
        print("Compile error")
        exit(1)

    # Use different color for each line
    step_count = (tol_end - tol_start) // tol_step
    colors = generate_rgb_color_palette(step_count, 1, 0.9)

    # Run simulation for each tolerance value
    for index, tol in enumerate(range(tol_start, tol_end, tol_step)):
        config['gross_tolerance'] = str(tol)
        if run_binary_program(config, False): # If simulation successful, make figure
            #config['pareto_figure_name'] = 'pareto_{}_{}_{}.png'.format(num_wells, production_gross, tol)
            config['pareto_figure_name'] = 'pareto_fronts.png'
            config['pareto_figure_color'] = colors[index]
            config['label_name'] = 'tol = {}'.format(tol)
            config['save_fig'] = index == step_count-1
            plot_csv(config)
        else:
            print("Program terminated with errors")
