python ./88/full_model_generation.py
if (( $? ))
  then figlet "FAILED" ;
else fstl ./88/Test.stl;
fi
