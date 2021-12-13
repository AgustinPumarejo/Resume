# Resume
## Fundación Cura
This project contains only documentation so far and all of it is in Spanish.

URL to Drive: https://drive.google.com/drive/folders/1YLukZtwkKuiUkq_IucbsCdgBmQ8D1fGR?usp=sharing

## Multi-Agent Simulation
Traffic simulation. It has two directories, the Mesa one which creates server and it can be used to visualize the simulation through a webpage and Traffic Model which is a Unity project that calls the server and displays the simulation using 3D graphics. It also contains demo.mp4 which shows how the program works.

### How to run
The simplest way to run it is direcly with the mesa visalization module which only requires anaconda or miniconda and can be done in the following way.

1. Pull the repository
2. Create an environment using the environment.yml file

`conda env create -f environment.yml`

3. Run the server.py script

`python .\server.py`
    
If you want to run the simulation in Unity, you need to install it and open a project from the Traffic Model folder using version 2020.3.22f1. Then, repeat the steps above but instead run the unity.py script in the end and once the server is running, open Unity, go to the BuildCity scene and run it.

## Circuit Sandbox
This one has a readme of its own that specifies the requirements for running the project since the database isn't hosted anywhere. "Diagramas y Especificaciones" contains the documentation of the project, "CircuitSandboxMVP" contains a set of files meant to be opened with Unity, you can access the scripts from the game via the "Scripts" folder inside "Assets". "Frontend" and "Backend" should be self-explanatory.

Running the "juego" HTML file locally, found inside "Frontend", should allow you to play the game and use the page but the database will not be functional.

## Syntax Highlighter
This is a program that receives a css file and outputs an html file with its syntax highlighted. To test the file, on needs to install racket and preferable Dr. Racket as well and run this command “(directory-CSS-To-HTML 1)”. All css files that are on the same folder as the syntax highlighter will be converted. There is a sample file with its html file already created.
