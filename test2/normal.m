function output = normal( in )

  in = double(in);
  if( max(in) - min(in) == 0 )
    output = uint8(in);
  else
    output = uint8((in - min(min(in))*ones(size(in)))*(255/(max(max(in)) - min(min(in)))));
  end

end
