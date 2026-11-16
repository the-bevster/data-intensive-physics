#!/bin/bash

while true; do
    echo "1) Show my jobs"
    echo "2) Submit slurm_graph"
    echo "3) Common problems"
    echo "4) Exit"
    echo "5) Check virtual enviroments"
    echo "6) activate dip-numba"
    echo "7) enter cython directory"
    echo "8) enter github directory"

    read -p "Choose: " choice

    case $choice in
        1)
            squeue -u $USER
            ;;

        2)
            sbatch slurm_graph
            ;;

        3)
            while true; do
                echo
                echo "COMMON PROBLEMS"
                echo "1) Job stuck in PENDING"
                echo "2) Job failed"
                echo "3) Check job output/error"
                echo "4) Check job history"
                echo "5) Back"

                read -p "Choose problem: " problem

                case $problem in
                    1)
                        echo "Your queued jobs:"
                        squeue -u $USER

                        echo
                        read -p "Enter job ID: " jobid
                        scontrol show job $jobid
                        ;;

                    2)
                        echo "Recent jobs:"
                        sacct -u $USER --starttime today

                        echo
                        read -p "Enter job ID: " jobid
                        sacct -j $jobid --format=JobID,State,ExitCode,Elapsed,MaxRSS
                        ;;

                    3)
                        echo "--- ERROR FILE ---"
                        cat pi_graph.err

                        echo
                        echo "--- OUTPUT FILE ---"
                        cat pi_graph.out
                        ;;

                    4)
                        sacct -u $USER --starttime today \
                            --format=JobID,JobName,State,Elapsed,ExitCode
                        ;;

                    5)
                        break
                        ;;

                    *)
                        echo "Invalid option"
                        ;;
                esac
            done
            ;;

        4)
            break
            ;;

        5)
            source ~/initMamba.sh
            mamba env list
            ;;

        6)
            source ~/initMamba.sh
            mamba activate dip-numba
            ;;

        7)  cd ~/data-intensive-physics/cython
            ;;

        8)  cd ~/data-intensive-physics/github-project
            ;;

        *)
            echo "Invalid option"
            ;;
    esac

    echo
done