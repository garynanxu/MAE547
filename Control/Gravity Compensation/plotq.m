  figure(1)
  plot(time, qdgrav(1)*ones(size(time)),'--',time,q(:,1));
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 1 pos');

  figure(2)
  plot(time, qdgrav(2)*ones(size(time)),'--',time,q(:,2));
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 2 pos');