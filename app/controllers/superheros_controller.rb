class SuperherosController < ApplicationController
    before_action :authorize!, only: [:new, :create, :edit, :update, :destroy]
    before_action :superhero_get!, only: [:show, :edit, :update, :destroy]

    def index
        @superheros = Superhero.all
    end

    def show
    end

    def new
        @superhero = Superhero.new
    end

    def create
        superhero = Superhero.new(superhero_params)
        if superhero.valid?
            superhero.save
            redirect_to superhero
        else
            flash[:message] = supehero.errors.full_messages
            redirect_to new_superhero_path
        end
    end

    def edit
    
    end

    def update
        supehero = @supehero.update(params.require(:supehero).permit(:name, :description, :imgurl))
        if supehero.valid?
            redirect_to supehero_path(@supehero)
        else
            flash[:message] = supehero.errors.full_messages
            redirect_to edit_supehero_path(@supehero)
        end
    end

    def destroy
        @superhero.destroy
        redirect_to superheros_path
    end
    private

    def superhero_params
        params.require(:superhero).permit(:name, :description, :imgurl)
    end

    def superhero_get!
        @superhero = Superhero.find_by(id: params[:id])
    end
end