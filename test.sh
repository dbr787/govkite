governed_pipeline_upload () {
  if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
  else
    echo "$# arguments supplied"
  fi
}

governed_pipeline_upload
