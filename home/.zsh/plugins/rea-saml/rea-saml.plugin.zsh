function saml_info() {
  if [ -n "$AWS_ROLE" ]; then
    ((remaining = ($AWS_EXPIRE - `date +%s`) / 60))
    if [ $remaining -gt 0 ]; then
      echo "${fg[yellow]}($AWS_ROLE $(printf "%sm" $remaining))"
    else
      echo "${fg[red]}($AWS_ROLE EXPIRED)"
    fi
  fi
}
