# Resume

## Circuit Sandbox
This is a videogame hosted in a webpage, **there's a Demo.mp4 file inside it that shows how it works overall.**

This one has a readme of its own that specifies the requirements for running the project since the database isn't hosted anywhere. "Diagramas y Especificaciones" contains the documentation of the project, "CircuitSandboxMVP" contains a set of files meant to be opened with Unity, you can access the scripts from the game via the "Scripts" folder inside "Assets". "Frontend" and "Backend" should be self-explanatory.

Running the "juego" HTML file locally, found inside "Frontend", should allow you to play the game and use the page but the database will not be functional.

## Multi-Agent Simulation
Traffic simulation. It has two directories, the Mesa one which creates server and it can be used to visualize the simulation through a webpage and Traffic Model which is a Unity project that calls the server and displays the simulation using 3D graphics. **It also contains demo.mp4 which shows how the program works.**

### How to run
The simplest way to run it is directly with the mesa visualization module which only requires anaconda or miniconda and can be done in the following way.

1. Pull the repository
2. Create an environment using the environment.yml file and activate it.

`conda env create -f environment.yml`

`conda activate TrafficModel`

3. Run the server.py script

`python .\server.py`
    
If you want to run the simulation in Unity, you need to install it and open a project from the Traffic Model folder using version 2020.3.22f1. Then, repeat the steps above but instead run the unity.py script in the end and once the server is running, open Unity, go to the BuildCity scene and run it.
