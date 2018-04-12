class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if params[:figure][:title_ids]
      @figure.title_ids = params[:figure][:title_ids]
    end
    if params[:figure][:landmark_ids]
      @figure.landmark_ids = params[:figure][:landmark_ids]
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:figure_id' do
    @figure = Figure.find(params[:figure_id])
    erb :'figures/show'
  end

  get '/figures/:figure_id/edit' do
    @figure = Figure.find(params[:figure_id])
    erb :'figures/edit'
  end

  patch '/figures/:figure_id' do
    @figure = Figure.find(params[:figure_id])
    @figure.update(params[:figure])
    @figure.titles = Title.find_or_create_by(name: params[:title][:name])
    @figure.landmarks = Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
