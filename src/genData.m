% NB: the randomly generated datasets will be different everytime this
% function is called, so be CAREFUL you compare ALL methods on the same
% dataset
function [type, X, Y, Xt, Yt] = genData(identifier)

setenv('LC_ALL','C') % what?

switch identifier

  case 'sparse_degree6_target'  % for testing the recovery of a known sparse polynomial target
      d = 20; % dimensionality of observations
      ntrain = 20000;
      ntest = 5000;
      poly_target = @(X) X(:,1).^6 - 10*X(:,2).*X(:,3).*X(:,20);

      coord_biases = randn(1,d);
      X = bsxfun(@plus, randn(ntrain,d)/sqrt(d), coord_biases);
      Y = poly_target(X);

      Xt = bsxfun(@plus, randn(ntest,d)/sqrt(d), coord_biases);
      Yt = poly_target(Xt);
      
      type = 'regression';
      num_class = 0;

  case 'gaussian_dense_degree6_target' % for testing the recovery of a known dense polynomial target
      r = 6;
      d = 20;
      ntrain = 20000;
      ntest = 5000;
      
      coeffs = ...
      [
         0.735573 0.441288 0.377123 1.131124 0.200107 1.430176 0.009410 -0.380925 0.110141 -1.024516 -1.515205 0.647655 -0.996674 0.952360 0.871872 0.734857 -1.619379 -1.138630 -0.146964 -0.433510;
         0.269005 0.293258 1.208179 0.789184 -0.327265 0.699002 0.258783 1.347088 0.137128 0.224344 -0.362332 -0.421928 -2.101144 -0.926531 -2.485790 -1.821630 -0.116259 -0.352076 1.227481 -1.016710;
         -0.282870 0.114825 0.417891 -0.431711 -2.007431 -1.037631 -0.325595 0.080521 1.666411 3.228201 0.508527 0.273968 1.065272 0.016168 -1.722955 -0.157820 1.888403 0.538032 0.949480 -1.035399;
         -0.313803 0.308303 0.247670 1.952855 1.320125 -0.904128 -0.449221 -2.348604 0.690312 0.790171 -0.219469 0.155736 0.758364 -0.452549 -0.713566 -0.316094 0.564512 1.042582 -0.868994 -0.232535;
         0.050791 -0.796758 0.898736 0.461890 1.641266 0.522868 -0.060291 -0.809712 0.128681 0.039534 0.474462 -0.035134 1.376925 1.703908 1.033305 -0.286391 0.243438 -0.388820 -0.935203 0.348896;
         -0.121259 0.072315 0.769205 -1.526512 0.491080 0.430415 -1.040666 0.643362 -2.017093 -1.717236 -1.540050 -0.279976 -1.194310 0.748628 1.224099 0.133256 0.022881 1.027043 -1.075202 1.259628
      ]; % should be an r-by-d matrix
  
      poly_target = @(X) prod(X*coeffs',2); % Prod(<x, coeffs(i,:)>, i=1,...,r)
      
      coord_biases = randn(1,d);
      X = bsxfun(@plus, randn(ntrain,d)/sqrt(d), coord_biases);
      Y = poly_target(X);

      Xt = bsxfun(@plus, randn(ntest,d)/sqrt(d), coord_biases);
      Yt = poly_target(Xt);
      
      type = 'regression';
      num_class = 0;
    
  case 'laplacian_dense_degree6_target'
    r = 6;
    d = 20;
    ntrain = 20000;
    ntest = 5000;

    %laprnd(r, d, 0, 1)
    coeffs = ...
    [
      -0.252179, 0.798691, -0.601196, 1.824350, -0.539981, -0.295871, -0.153285, 0.306487, -1.103082, 0.363155, 0.111551, -1.245493, -0.092017, 0.823602, 2.607729, 2.045926, 0.089553, -0.652396, 3.312511, 1.821572;
      -0.392325, -0.773052, -0.161617, -0.093657, 1.415639, -0.569480, 0.910591, -0.493107, 0.728105, 0.469145, 0.850028, 0.000706, 0.586079, -0.661462, -0.809924, 0.239589, 1.427500, -0.166025, 0.258627, 0.479199;
      1.365321, 0.003119, -0.285997, 1.503231, 0.528674, -0.332600, 0.184335, -0.035101, 0.810519, 0.512788, -0.419284, 0.031211, -0.858611, -0.352188, -0.528248, 0.900622, 0.410861, 2.939671, -1.080773, 0.277957;
      -1.609834, 4.677022, -0.550312, -3.147226, 0.748218, 0.130943, 2.855629, -0.159423, -0.243161, -0.177270, 0.198393, -1.211243, 0.193714, -0.024029, 0.366500, -0.154465, -0.022941, -0.153641, -1.858225, 0.033763;
      0.144940, -0.241367, 1.454946, 0.176246, 0.112367, 0.762477, -0.634957, 0.156794, -0.106534, -0.107796, 0.137506, 1.171836, -0.460702, -0.277270, -0.202533, 0.216613, 0.230387, 0.270330, 0.190513, -0.462683;
      -0.793005, -1.670758, 0.322654, 0.651729, 0.622162, -0.384053, 0.751319, 0.649766, 0.110340, 1.724126, 1.850097, 1.035471, -0.081360, 0.642582, 2.082589, 2.490755, 1.055620, 1.147642, 0.101968, 1.822114
    ]; % should be an r-by-d matrix

    poly_target = @(X) prod(X*coeffs', 2);
    coord_biases = laprnd(1,d);

    X = bsxfun(@plus, randn(ntrain, d)/sqrt(d), coord_biases);
    Y = poly_target(X);

    Xt = bsxfun(@plus, randn(ntest, d)/sqrt(d), coord_biases);
    Yt = poly_target(Xt);

    type = 'regression';
    num_class = 0;

  otherwise
  
    fprintf('Please enter a valid dataset identifier!\n');
    return

end
