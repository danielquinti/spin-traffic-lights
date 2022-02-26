inline wait(sem) {
	atomic {
		sem;
		sem=false
	}
}

inline signal(sem) {
	sem=true
}

bool control=true;
mtype = {red, yellow, green};
mtype light=red;
mtype light2=red;
#define printlight(light,pid) printf("Process %d is at %e\n",pid,light)

active proctype P() {
    do
    ::  if
		:: light==red -> wait(control); light=green
		:: light==yellow -> light=red; signal(control)
		:: light==green -> light=yellow
		fi
		printlight(light,_pid);
	od
}

active proctype Q() {
    do
    ::  if
		:: light2==red -> wait(control); light2=green
		:: light2==yellow -> light2=red; signal(control)
		:: light2==green -> light2=yellow
		fi
		printlight(light2,_pid)
	od
}
