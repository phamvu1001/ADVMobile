import 'package:flutter/material.dart';

class AnimatedGradientBorder extends StatefulWidget{
  const AnimatedGradientBorder({
    super.key,
    this.radius=30,
    this.blurRadius=30,
    this.spreadRadius=1,
    this.glowOpacity=0.3,
    this.topColor=Colors.red,
    this.bottomColor=Colors.blue,
    this.duration=const Duration(milliseconds: 500),
    this.thickness=3,
    this.child,
  });

  final double radius;
  final double blurRadius;
  final double spreadRadius;
  final Color topColor;
  final Color bottomColor;
  final double glowOpacity;
  final Duration duration;
  final double thickness;
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _AnimatedGradientBorder();

}

class _AnimatedGradientBorder extends State<AnimatedGradientBorder> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Alignment> _tlAlignAnim;
  late Animation<Alignment> _brAlignAnim;
  @override
  void initState(){
    super.initState();
    _controller=AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _tlAlignAnim=TweenSequence<Alignment>([
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.topLeft, end: Alignment.topRight),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.topRight, end: Alignment.bottomRight),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1
      ),
    ]).animate(_controller);

    _brAlignAnim=TweenSequence<Alignment>([
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.topLeft, end: Alignment.topRight),
          weight: 1
      ),
      TweenSequenceItem <Alignment>(
          tween: Tween<Alignment>(begin:Alignment.topRight, end: Alignment.bottomRight),
          weight: 1
      ),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints)
    {
      return Stack(
        children: [
          widget.child!=null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.child,
          ):const SizedBox.shrink(),
          ClipPath(
              clipper: _CenterCutPath(radius: widget.radius, thickness: widget.thickness),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Stack(
                      children: [
                        Container(
                          child: widget.child,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(widget.radius),
                            boxShadow: [
                              BoxShadow(
                                color: widget.topColor.withOpacity(widget.glowOpacity),
                                offset: const Offset(0, 0),
                                blurRadius: widget.blurRadius,
                                spreadRadius: widget.spreadRadius,
                              )
                            ],
                          ),
                        ),
                        Transform.scale(
                          alignment: _brAlignAnim.value,
                          scale: 0.9,
                          child: Container(
                            child: widget.child,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(widget.radius),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.bottomColor.withOpacity(widget.glowOpacity),
                                  offset: const Offset(0, 0),
                                  blurRadius: widget.blurRadius,
                                  spreadRadius: widget.spreadRadius,
                                )
                              ],
                            ),
                          ),
                        )
                        ,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(widget.radius),
                              ),
                              gradient: LinearGradient(
                                colors: [widget.topColor.withOpacity(0.8), widget.bottomColor.withOpacity(0.8)],
                                begin: _tlAlignAnim.value,
                                end: _brAlignAnim.value,
                              )
                          ),
                          child: widget.child,
                        )

                      ]
                  );
                },
              )
          ),
        ],
      );
    });
    }
}

class _CenterCutPath extends CustomClipper<Path>{
  final double radius;
  final double thickness;
  _CenterCutPath({
    this.radius=0,
    this.thickness=0,
  });

  @override
  Path getClip(Size size) {
    final rect=Rect.fromLTRB(-size.width, -size.width, size.width*2, size.height*2);
    final double width=size.width-thickness*2;
    final double height=size.height-thickness*2;
    final path=Path()
      ..fillType=PathFillType.evenOdd
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(thickness, thickness, width, height),
          Radius.circular(radius-thickness)),
    )
    ..addRect(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant _CenterCutPath oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness!=thickness;
  }
  
}