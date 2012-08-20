require 'spec_helper'
 
describe MoviesController do

  describe 'find same director movies' do
    
    it 'should call the model methods that performs same director search' do
      Movie.stub(:find)
      Movie.stub(:find_same_director)
      Movie.should_receive(:find).with(1)
      Movie.should_receive(:find_same_director)

      get :find_same_director, {:id => '1'}  
    end
    
    it 'should select the Same Director Results template for rendering' do
      Movie.stub(:find)
      Movie.stub(:find_same_director)
      get :find_same_director, {:id => '1'}
      response.should render_template('find_same_director')
    end
    
    it 'should make the same director search results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      fake_movie = mock('Movie')
      
      Movie.stub(:find_same_director).and_return(fake_results)
      Movie.stub(:find).and_return(fake_movie)
      
      get :find_same_director, {:id => '1'}
      # look for controller method to assign @movies e @movie
      assigns(:movies).should == fake_results
      assigns(:movie).should == fake_movie
    end
    
    it 'should make available notice message without diretor error' do
    
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => nil, :release_date => '25-Nov-1992'))

      get :find_same_director, {:id => '1'}
      
      flash[:notice].should eql("'Aladdin' has no director info")
      
    end
    
    it 'should redirect to movies path for movies with no director' do
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => nil, :release_date => '25-Nov-1992'))

      get :find_same_director, {:id => '1'}
      
      response.code.should == "302"
      response.should redirect_to(movies_path)

    end
    
    
    it 'should touch find_same_director in model method' do
    
        movie_test = Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Aladdin director', :release_date => '25-Nov-1992')
      
        get :find_same_director, {:id => '1'}
 
    end
    
    
    
  end
  
  describe 'Show Movie details' do    
    it 'call the model methods that performs show movie details' do   
      Movie.stub(:find)
      Movie.should_receive(:find).with(1)
      get :show, {:id => '1'} 
    end
    
    it 'should select the movie template for rendering' do
      Movie.stub(:find)
      get :show, {:id => '1'}
      response.should render_template('movie')
    end
    
    it 'should make movie details available to that template' do
 
      fake_movie = mock('Movie')
      
      Movie.stub(:find).and_return(fake_movie)
      
      get :show, {:id => '1'}
      # look for controller method to assign @movies e @movie
      assigns(:movie).should == fake_movie
    end     
  end
  
  
  describe 'Movie Create' do
    it 'call the mode method that perform movie create' do
      
      Movie.stub(:create!).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      Movie.should_receive(:create!)
      post :create, {:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'} 
    end

    it 'should redirect to movies template for rendering' do
      Movie.stub(:create!).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      post :create, {:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'}
      response.code.should == "302"
      response.should redirect_to(movies_path)

    end
    
    it 'should make success message available to that template' do
      
      Movie.stub(:create!).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      
      post :create, {:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'}
      # look for controller method to assign @movies e @movie
      flash[:notice].should eql("Aladdin was successfully created.")
    end
  end
  
  describe 'Movie Edit' do
    it 'should call the model methods that get the movie' do
      Movie.stub(:find)
      Movie.should_receive(:find).with(1)
      get :edit, {:id => '1'}  
    end
    
    it 'should select the Details movie template for rendering' do
      Movie.stub(:find)
      get :edit, {:id => '1'}
      response.should render_template('edit')
    end
    
    it 'should make the movie details are  available to that template' do
      fake_movie = mock('Movie')
      
      Movie.stub(:find).and_return(fake_movie)
      
      get :edit, {:id => '1'}
      # look for controller method to assign @movie
      assigns(:movie).should == fake_movie
    end
  end
  
  describe 'Movie Update' do
    it 'should call model methods to update' do
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      Movie.should_receive(:find).with(1)
      
      put :update, {:id=>1, :title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'} 
    end
    
    it 'should redirect to movie_path' do
       Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      put :update, {:id=>1, :title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'} 
      response.code.should == "302"
      response.should redirect_to(movie_path)
    end

    it 'should make new movie details available for view' do
      test_movie = Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992')
      
      Movie.stub(:find).and_return(test_movie)
      
      put :update, {:id=>1, :title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'} 

      # look for controller method to assign @movies e @movie
      assigns(:movie).should == test_movie   
    end


    it 'should make success notice available for view' do
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      put :update, {:id=>1, :title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'} 

      flash[:notice].should eql("Aladdin was successfully updated.")
    end
  end
  
  describe 'Movie Destroy' do
    it 'should call model methods to destroy' do
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      Movie.should_receive(:find).with(1)
      
      delete :destroy, {:id=>1} 
    end
    
    it 'after delete should redirect to movies_path' do
       Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      delete :destroy, {:id=>1} 
      response.code.should == "302"
      response.should redirect_to(movies_path)
    end

    it 'should make delete success notice available for view' do
      Movie.stub(:find).and_return(Movie.new(:id=>1,:title => 'Aladdin', :rating => 'G', :director => 'Director Alladin', :release_date => '25-Nov-1992'))
      delete :destroy, {:id=>1}
      flash[:notice].should eql("Movie 'Aladdin' deleted.")
    end
  end  
  
  describe 'Movies List' do
    it 'should call model method to load list without order' do
      Movie.should_receive(:find_all_by_rating)
      get :index
    end

    it 'should call model method to load list ordered by title' do
      get :index, {:ratings=>{},:sort=>'title'}
    end

    it 'should call model method to load list ordered by release_date' do
      get :index, {:ratings=>{},:sort=>'release_date'}
    end  
  end
  
end  
