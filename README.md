# Resume
## Fundación Cura
This project contains only documentation so far and all of it is in Spanish.

URL to Drive: https://drive.google.com/drive/folders/1YLukZtwkKuiUkq_IucbsCdgBmQ8D1fGR?usp=sharing

## Multi-Agent Simulation
Traffic simulation. It has two directories, the Mesa one which creates server and it can be used to visualize the simulation through a webpage and Traffic Model which is a Unity project that calls the server and displays the simulation using 3D graphics. It also contains demo.mp4 which shows how the program works.

### How to run
The simplest way to run it is directly with the mesa visualization module which only requires anaconda or miniconda and can be done in the following way.

1. Pull the repository
2. Create an environment using the environment.yml file and activate it.

`conda env create -f environment.yml`

`conda activate TrafficModel`

3. Run the server.py script

`python .\server.py`
    
If you want to run the simulation in Unity, you need to install it and open a project from the Traffic Model folder using version 2020.3.22f1. Then, repeat the steps above but instead run the unity.py script in the end and once the server is running, open Unity, go to the BuildCity scene and run it.

## Circuit Sandbox
This one has a readme of its own that specifies the requirements for running the project since the database isn't hosted anywhere. "Diagramas y Especificaciones" contains the documentation of the project, "CircuitSandboxMVP" contains a set of files meant to be opened with Unity, you can access the scripts from the game via the "Scripts" folder inside "Assets". "Frontend" and "Backend" should be self-explanatory.

Running the "juego" HTML file locally, found inside "Frontend", should allow you to play the game and use the page but the database will not be functional.

## DIF
This one is a mobile app created using flutter and Android Studio. Unfortunately, the app only works if a server is active and the server we used was on a teammate's AWS account. However, the code is still there inside the lib folder and all the documentation is in this drive: https://drive.google.com/drive/folders/1Adl4OGIedpogufbzcY-cO8lL-YJTU9R2?usp=sharing

## Advanced Algorithm Project
In this project, a teammate and I used several algorithms related to graphs in order to calculate different properties of a set of districts. The properties that we calculated where:
1. Minimum path between any two districts
2. Minimum spanning tree
3. Maximum flow from one district to another
4. Closest pair of districts (in this one we used a set of point in a plane as an input instead of a graph)

To calculate this we used Depth Fist Search, Floyd-Warshal for calculating the shortest path, Ford-Fulkerson for the maximum flow algorithm, krustal's for the minimum spanning tree and the closest pair of points algorithm.

## Syntax Highlighter
This is a program that receives a css file and outputs an html file with its syntax highlighted. To test the file, on needs to install racket and preferable Dr. Racket as well and run this command “(directory-CSS-To-HTML 1)”. All css files that are on the same folder as the syntax highlighter will be converted. There is a sample file with its html file already created.
