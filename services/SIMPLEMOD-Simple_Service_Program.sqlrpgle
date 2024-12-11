**free
ctl-opt nomain;

// service program procedure called 'getsystemname'
dcl-proc getsystemname export;
  dcl-pi getsystemname;
    systemname char(8);
  end-pi;
    
  exec sql
      VALUES CURRENT SERVER INTO :systemname ;

  return;

end-proc;